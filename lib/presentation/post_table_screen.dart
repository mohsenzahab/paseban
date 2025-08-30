import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paseban/app/locator.dart';
import 'package:paseban/core/bloc/widgets/bloc_message_listener.dart';
import 'package:paseban/presentation/cubit/monthly_post_table_cubit.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

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
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 0,
                  child: Text('افزودن سرباز'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PostsScreen(),
                    ),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: BlocMessageListener.group(
        blocs: [sl<MonthlyPostTableCubit>()],
        child: const GuardTable(),
      ),
    );
  }
}

class GuardDataSource extends DataGridSource {
  GuardDataSource(List<Soldier> guards, MonthlyPostTableState state) {
    final range = state.dateRange;

    soldiers =
        (guards..sort(
              (a, b) => a.dateOfEnlistment.compareTo(b.dateOfEnlistment),
            ))
            .map((e) {
              final cells = [
                DataGridCell<Soldier>(columnName: 'name', value: e),
                ...[
                  for (
                    var i = range.start;
                    !i.isAfter(range.end);
                    i = i.add(Duration(days: 1))
                  )
                    DataGridCell<String>(
                      columnName: i.toIso8601String(),
                      value: 'N/A',
                    ),
                ],
              ];
              return DataGridRow(cells: cells);
            })
            .toList();
  }

  List<DataGridRow> soldiers = [];

  @override
  List<DataGridRow> get rows => soldiers;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map((cell) {
        final value = cell.value;
        if (value is Soldier) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text('${value.firstName} ${value.lastName}'),
          );
        }
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Text(value.toString()),
        );
      }).toList(),
    );
  }
}

class GuardTable extends StatelessWidget {
  const GuardTable({super.key});

  @override
  Widget build(BuildContext _) {
    return BlocBuilder<MonthlyPostTableCubit, MonthlyPostTableState>(
      builder: (context, state) {
        final dataSource = GuardDataSource(
          state.soldiers.values.toList(),
          state,
        );
        final columns = [
          GridColumn(
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
              columnName: i.toIso8601String(),
              label: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: i.weekDay(CalendarMode.jalali) == 7
                      ? Colors.red
                      : Colors.white,
                ),
                padding: const EdgeInsets.all(8.0),
                child: Text('${i.jf.wN} ${i.jf.dd}'),
              ),
            ),
        ];
        return SfDataGrid(
          source: dataSource,
          columns: columns,
          onCellTap: (details) {
            final row = details.rowColumnIndex.rowIndex - 1;
            final column = details.rowColumnIndex.columnIndex;
            final value = dataSource.soldiers[row].getCells()[column].value;
            if (details.column.columnName == 'soldier') {
              SoldierForm.show(context, soldier: value);
            }
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
          frozenColumnsCount: 1, // ستون اول (نام) ثابت بمونه
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
