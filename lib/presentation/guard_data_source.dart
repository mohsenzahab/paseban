import 'package:flutter/material.dart';
import 'package:paseban/app/locator.dart';
import 'package:paseban/core/utils/date_helper.dart';
import 'package:paseban/domain/enums.dart';
import 'package:paseban/domain/models/guard_post.dart';
import 'package:paseban/domain/models/soldier.dart';
import 'package:paseban/domain/models/soldier_post.dart';
import 'package:paseban/presentation/cubit/monthly_post_table_cubit.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

bool isHoliday(DateTime i, MonthlyPostTableState state) {
  return i.weekDay(CalendarMode.jalali) == 7 || state.holidays.contains(i);
}

Color cellColor(bool isHoliday) {
  return isHoliday ? kColorHoliday : Colors.white;
}

const kColorHoliday = Colors.redAccent;

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
                DataGridCell<String>(
                  columnName: 'postsCount',
                  value: soldierPosts.length.toString(),
                ),
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

  dynamic newCellValue;
  List<DataGridRow> soldiers = [];
  final MonthlyPostTableState state;

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
    if (date == null) return null;
    final datePostsCount = _getDatePostsCount(rowColumnIndex);
    final filteredGuardPosts = guardPosts.values.fold(<RawGuardPost>[], (
      previousValue,
      gp,
    ) {
      final shiftCount = gp.shiftsPerDay;

      if (datePostsCount.containsKey(gp.id) &&
          datePostsCount[gp.id]! >= shiftCount) {
        return previousValue;
      }
      if (gp.includesDate(date)) {
        previousValue.add(gp);
      }
      return previousValue;
    });
    if (value != null &&
        !filteredGuardPosts.contains(guardPosts[value.guardPostId])) {
      filteredGuardPosts.add(guardPosts[value.guardPostId]!);
    }
    return DropdownButtonHideUnderline(
      child: DropdownButton<RawGuardPost>(
        isExpanded: true,
        value: value == null ? null : guardPosts[value.guardPostId],
        items: [
          ...filteredGuardPosts.map((e) {
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
              date: date,
              editType: EditType.manual,
            );
          }
          submitCell();
        },
      ),
    );
  }

  Map<int, int> _getDatePostsCount(RowColumnIndex rowColumnIndex) {
    Map<int, int> datePostsCount = {};
    for (var row in rows) {
      final post =
          row.getCells()[rowColumnIndex.columnIndex].value as SoldierPost?;
      if (post != null) {
        if (datePostsCount.containsKey(post.guardPostId)) {
          datePostsCount[post.guardPostId!] =
              datePostsCount[post.guardPostId!]! + 1;
        } else {
          datePostsCount[post.guardPostId!] = 1;
        }
      }
    }
    return datePostsCount;
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map((cell) {
        final date = DateTime.tryParse(cell.columnName);
        final color = date == null ? null : cellColor(isHoliday(date, state));
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
        } else if (value is String) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(value),
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
  List<DataGridRow> get rows => soldiers;
}
