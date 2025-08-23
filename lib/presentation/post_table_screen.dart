import 'package:flutter/material.dart';
import 'package:paseban/core/utils/date_helper.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../domain/enums.dart';
import '../domain/models/soldier.dart';

class PostTableScreen extends StatelessWidget {
  const PostTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("جدول سربازان")),
        body: const GuardTable(),
      ),
    );
  }
}

class GuardDataSource extends DataGridSource {
  GuardDataSource(List<Soldier> guards) {
    _guards = guards
        .map(
          (e) => DataGridRow(
            cells: [
              DataGridCell<String>(
                columnName: 'name',
                value: '${e.firstName} ${e.lastName}',
              ),
              ...[
                for (var i = 1; i <= 31; i++)
                  DataGridCell<String>(columnName: i.toString(), value: 'N/A'),
              ],
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> _guards = [];

  @override
  List<DataGridRow> get rows => _guards;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map((cell) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Text(cell.value.toString()),
        );
      }).toList(),
    );
  }
}

class GuardTable extends StatelessWidget {
  const GuardTable({super.key});

  @override
  Widget build(BuildContext context) {
    final monthEndDate = Jalali.now().copy(day: 1).addMonths(1).addDays(-1);
    final guards = [
      Soldier(
        firstName: 'محسن',
        lastName: 'ر',
        rank: MilitaryRank.seniorLieutenant,
        dateOfEnlistment: DateTime.now(),
      ),
      Soldier(
        firstName: 'محسن',
        lastName: 'ر',
        rank: MilitaryRank.seniorLieutenant,
        dateOfEnlistment: DateTime.now(),
      ),
      Soldier(
        firstName: 'محسن',
        lastName: 'ر',
        rank: MilitaryRank.seniorLieutenant,
        dateOfEnlistment: DateTime.now(),
      ),
      Soldier(
        firstName: 'محسن',
        lastName: 'ر',
        rank: MilitaryRank.seniorLieutenant,
        dateOfEnlistment: DateTime.now(),
      ),
      Soldier(
        firstName: 'محسن',
        lastName: 'ر',
        rank: MilitaryRank.seniorLieutenant,
        dateOfEnlistment: DateTime.now(),
      ),
      Soldier(
        firstName: 'محسن',
        lastName: 'ر',
        rank: MilitaryRank.seniorLieutenant,
        dateOfEnlistment: DateTime.now(),
      ),
      Soldier(
        firstName: 'محسن',
        lastName: 'ر',
        rank: MilitaryRank.seniorLieutenant,
        dateOfEnlistment: DateTime.now(),
      ),
      Soldier(
        firstName: 'محسن',
        lastName: 'ر',
        rank: MilitaryRank.seniorLieutenant,
        dateOfEnlistment: DateTime.now(),
      ),
      Soldier(
        firstName: 'محسن',
        lastName: 'ر',
        rank: MilitaryRank.seniorLieutenant,
        dateOfEnlistment: DateTime.now(),
      ),
      Soldier(
        firstName: 'محسن',
        lastName: 'ر',
        rank: MilitaryRank.seniorLieutenant,
        dateOfEnlistment: DateTime.now(),
      ),
      Soldier(
        firstName: 'محسن',
        lastName: 'ر',
        rank: MilitaryRank.seniorLieutenant,
        dateOfEnlistment: DateTime.now(),
      ),
      Soldier(
        firstName: 'محسن',
        lastName: 'ر',
        rank: MilitaryRank.seniorLieutenant,
        dateOfEnlistment: DateTime.now(),
      ),
    ];

    final dataSource = GuardDataSource(guards);

    return SfDataGrid(
      source: dataSource,
      columns: [
        GridColumn(
          columnName: 'name',
          label: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text('name'),
          ),
        ),

        for (
          Jalali i = Jalali.now().copy(day: 1);
          i <= monthEndDate.addDays(1);
          i = i.addDays(1)
        )
          GridColumn(
            columnName: i.toString(),
            label: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: Text('${i.formatter.wN} ${i.formatter.dd}'),
            ),
          ),
      ],
      frozenColumnsCount: 1, // ستون اول (نام) ثابت بمونه
      frozenRowsCount: 0, // هدر بالا ثابت بمونه
    );
  }
}
