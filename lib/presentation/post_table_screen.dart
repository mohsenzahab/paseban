import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_date_picker/intl_date_picker.dart';
import 'package:paseban/app/locator.dart';
import 'package:paseban/core/bloc/widgets/bloc_message_listener.dart';
import 'package:paseban/presentation/cubit/monthly_post_table_cubit.dart';
import 'package:paseban/presentation/guard_data_source.dart';
import 'package:paseban/presentation/policies_screen.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../core/constant/space.dart';
import '../core/utils/calendar/jalali_delegate.dart';
import '../core/utils/date_helper.dart';
import '../domain/models/soldier.dart';
import 'forms/soldier_form.dart';
import 'posts_screen.dart';

class PostTableScreen extends StatelessWidget {
  const PostTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("جدول سربازان"),
        centerTitle: true,

        actions: [
          FilledButton(
            onPressed: () {
              context.read<MonthlyPostTableCubit>().runScheduler();
            },
            child: Icon(Icons.auto_awesome_rounded),
          ),
          kSpaceH12,

          FilledButton(
            onPressed: () {
              context.read<MonthlyPostTableCubit>().deleteAllAutoPosts();
            },
            child: Row(
              children: [
                Icon(Icons.auto_awesome_rounded),
                kSpaceH8,
                Icon(Icons.delete),
              ],
            ),
          ),
          kSpaceH12,
          FilledButton(
            onPressed: () {
              context.read<MonthlyPostTableCubit>().clearPreviewPosts();
            },
            child: Icon(Icons.restart_alt_rounded),
          ),
          kSpaceH12,
          FilledButton(
            onPressed: () {
              context.read<MonthlyPostTableCubit>().clearAllPosts();
            },
            child: Icon(Icons.clear_rounded),
          ),
          kSpaceH12,
          FilledButton(
            onPressed: () {
              context.read<MonthlyPostTableCubit>().savePreviewPosts();
            },
            child: Icon(Icons.save),
          ),
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 0,
                  child: Text('افزودن پست'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PostsScreen(),
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 1,
                  child: Text('سیاست ها'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PoliciesScreen(),
                    ),
                  ),
                ),
              ];
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: BlocBuilder<MonthlyPostTableCubit, MonthlyPostTableState>(
            // buildWhen: (previous, current) =>
            //     previous.dateRange != current.dateRange,
            builder: (context, state) {
              final range = state.dateRange;
              return StatefulBuilder(
                builder: (context, setState) {
                  return Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          showIntlDatePicker(
                            context: context,
                            firstDate: DateTime(DateTime.now().year, 6, 1),
                            lastDate: DateTime.now().copyWith(day: 30),
                            initialDate: DateTime.now(),
                            calendarMode: Calendar.jalali,
                          ).then((value) {
                            if (value != null) {
                              context
                                  .read<MonthlyPostTableCubit>()
                                  .setDateRange(value, range.end);
                            }
                          });
                        },
                        child: Text(formatJalaliCompactDate(range.start)),
                      ),
                      Text(' تا '),
                      OutlinedButton(
                        onPressed: () {
                          showIntlDatePicker(
                            context: context,
                            firstDate: DateTime(DateTime.now().year, 6, 1),
                            lastDate: DateTime.now().copyWith(day: 30),
                            initialDate: DateTime.now(),
                            calendarMode: Calendar.jalali,
                          ).then((value) {
                            if (value != null) {
                              context
                                  .read<MonthlyPostTableCubit>()
                                  .setDateRange(range.start, value);
                            }
                          });
                        },
                        child: Text(formatJalaliCompactDate(range.end)),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
      body: BlocMessageListener.group(
        blocs: [sl<MonthlyPostTableCubit>()],
        child: const GuardTable(),
      ),
    );
  }
}

class GuardTable extends StatelessWidget {
  const GuardTable({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<MonthlyPostTableCubit>(context);
    return BlocBuilder<MonthlyPostTableCubit, MonthlyPostTableState>(
      builder: (context, state) {
        final dataSource = GuardDataSource(
          state.soldiers.values.toList(),
          state,
        );
        final columns = [
          GridColumn(
            columnWidthMode: ColumnWidthMode.auto,
            allowEditing: false,
            maximumWidth: 50,
            columnName: 'postsCount',
            label: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: Text('# پست'),
            ),
          ),
          GridColumn(
            allowEditing: false,
            columnName: 'soldier',
            label: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: Text('سرباز'),
            ),
          ),

          for (
            DateTime i = state.dateRange.start;
            !i.isAfter(state.dateRange.end);
            i = i.add(Duration(days: 1))
          )
            GridColumn(
              allowEditing: true,
              columnName: i.toIso8601String(),
              label: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: cellColor(isHoliday(i, state)),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Text('${i.jf.wN} ${i.jf.dd}'),
              ),
            ),
        ];
        return SfDataGrid(
          source: dataSource,
          columns: columns,
          navigationMode: GridNavigationMode.cell,
          selectionMode: SelectionMode.single,
          editingGestureType: EditingGestureType.tap,
          allowEditing: true,
          onCellTap: (details) {
            final row = details.rowColumnIndex.rowIndex - 1;
            final column = details.rowColumnIndex.columnIndex;
            if (row == -1) {
              if (column > 1) {
                final date = DateTime.parse(details.column.columnName);
                cubit.toggleHoliday(date);
              }
              return;
            }
            final soldier =
                dataSource.soldiers[row].getCells()[1].value as Soldier;
            if (details.column.columnName == 'soldier') {
              SoldierForm.show(context, soldier: soldier);
            } else {}
          },
          onCellLongPress: (details) {
            final row = details.rowColumnIndex.rowIndex - 1;
            final column = details.rowColumnIndex.columnIndex;
            final Soldier value = dataSource.soldiers[row]
                .getCells()[column]
                .value;
            if (details.column.columnName == 'soldier') {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('حذف سرباز'),
                    content: Text(
                      'آیا مطمئن هستید که میخواهید سرباز را حذف کنید؟',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('لغو'),
                      ),
                      FilledButton(
                        onPressed: () {
                          context.read<MonthlyPostTableCubit>().deleteSoldier(
                            value,
                          );
                          Navigator.pop(context);
                        },
                        child: Text('حذف'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          frozenColumnsCount: 2, // ستون اول (نام) ثابت بمونه
          frozenRowsCount: 0, // هدر بالا ثابت بمونه
          footer: Align(
            child: FilledButton(
              onPressed: () {
                SoldierForm.show(context);
              },
              child: Text('اضافه کردن سرباز'),
            ),
          ),
        );
      },
    );
  }
}
