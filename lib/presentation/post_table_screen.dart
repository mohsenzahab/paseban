import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paseban/app/locator.dart';
import 'package:paseban/core/bloc/widgets/bloc_message_listener.dart';
import 'package:paseban/domain/models/soldier_post.dart';
import 'package:paseban/presentation/cubit/monthly_post_table_cubit.dart';
import 'package:paseban/presentation/policies_screen.dart';
import 'package:path/path.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../core/utils/date_helper.dart';
import '../domain/enums.dart';
import '../domain/models/guard_post.dart';
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
      ),
      body: BlocMessageListener.group(
        blocs: [sl<MonthlyPostTableCubit>()],
        child: const GuardTable(),
      ),
    );
  }
}

class GuardDataSource extends DataGridSource {
  GuardDataSource(List<Soldier> guards, this.state) {
    final range = state.dateRange;

    soldiers =
        (guards..sort(
              (a, b) => a.dateOfEnlistment.compareTo(b.dateOfEnlistment),
            ))
            .map((soldier) {
              final soldierPosts = state.soldiersPosts[soldier.id] ?? {};
              final cells = [
                DataGridCell<Soldier>(columnName: 'name', value: soldier),
                ...[
                  for (
                    var i = range.start;
                    !i.isAfter(range.end);
                    i = i.add(Duration(days: 1))
                  )
                    DataGridCell<SoldierPost>(
                      columnName: i.dateOnly.toIso8601String(),
                      value: soldierPosts[i],
                    ),
                ],
              ];
              return DataGridRow(cells: cells);
            })
            .toList();
  }

  List<DataGridRow> soldiers = [];
  final MonthlyPostTableState state;

  dynamic newCellValue;

  @override
  Widget? buildEditWidget(
    DataGridRow dataGridRow,
    RowColumnIndex rowColumnIndex,
    GridColumn column,
    CellSubmit submitCell,
  ) {
    newCellValue = null;
    final guardPosts = state.guardPosts;
    final Soldier soldier = dataGridRow.getCells()[0].value;
    final soldierPosts = state.soldiersPosts[soldier.id] ?? {};
    final SoldierPost? value = dataGridRow
        .getCells()[rowColumnIndex.columnIndex]
        .value;
    final date = DateTime.tryParse(column.columnName);
    return DropdownButtonHideUnderline(
      child: DropdownButton<GuardPost>(
        isExpanded: true,
        value: value == null ? null : guardPosts[value.guardPostId],
        items: [
          ...guardPosts.values.map((e) {
            return DropdownMenuItem(
              value: e,
              child: FittedBox(child: Text(e.title)),
            );
          }),
          DropdownMenuItem(value: null, child: Text('_')),
        ],
        onChanged: (value) {
          if (value == null) {
            newCellValue = null;
          } else {
            newCellValue = SoldierPost(
              soldierId: soldier.id!,
              guardPostId: value.id!,
              date: date!,
              editType: EditType.manual,
            );
          }
          submitCell();
        },
      ),
    );
  }

  @override
  Future<void> onCellSubmit(
    DataGridRow dataGridRow,
    RowColumnIndex rowColumnIndex,
    GridColumn column,
  ) async {
    final SoldierPost? newValue = newCellValue;
    final SoldierPost? oldValue = dataGridRow
        .getCells()[rowColumnIndex.columnIndex]
        .value;
    if (newValue != oldValue) {
      if (newValue == null) {
        if (oldValue != null) {
          sl<MonthlyPostTableCubit>().deleteSoldierPost(oldValue);
          return;
        } else {
          return;
        }
      }
      // final date = DateTime.tryParse(column.columnName);
      // final rowIndex = rows.indexOf(dataGridRow);
      // rows[rowIndex]
      //     .getCells()[rowColumnIndex.columnIndex] = DataGridCell<SoldierPost>(
      //   columnName: column.columnName,
      //   value: newValue,
      // );
      return sl<MonthlyPostTableCubit>().updateSoldierPost(newValue);
    }
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map((cell) {
        final date = DateTime.tryParse(cell.columnName);
        final color = date == null ? null : _cellColor(date, state);
        final value = cell.value;
        if (value is Soldier) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text('${value.firstName} ${value.lastName}'),
          );
        } else if (value is SoldierPost) {
          return Container(
            color: color,

            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(state.guardPosts[value.guardPostId]!.title),
          );
        }
        return Container(
          color: color,

          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Text('_'),
        );
      }).toList(),
    );
  }

  @override
  List<DataGridRow> get rows => soldiers;
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
                decoration: BoxDecoration(color: _cellColor(i, state)),
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
              if (column > 0) {
                final date = DateTime.parse(details.column.columnName);
                cubit.toggleHoliday(date);
              }
              return;
            }
            final soldier =
                dataSource.soldiers[row].getCells()[0].value as Soldier;
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

Color _cellColor(DateTime i, MonthlyPostTableState state) {
  return i.weekDay(CalendarMode.jalali) == 7 || state.holidays.contains(i)
      ? kColorHoliday
      : Colors.white;
}

const kColorHoliday = Colors.redAccent;
