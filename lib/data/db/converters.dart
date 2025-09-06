import 'dart:convert';

import 'package:drift/drift.dart';

import '../../domain/enums.dart';
import '../../domain/models/weekday.dart';
import 'app_database.dart';

class EnumIndexConverter<T extends Enum> extends TypeConverter<T, int> {
  final List<T> values;
  const EnumIndexConverter(this.values);

  @override
  T fromSql(int fromDb) => values[fromDb];

  @override
  int toSql(T value) => value.index;
}

class WeekdayListConverter extends TypeConverter<List<List<Weekday>>, String> {
  const WeekdayListConverter();

  @override
  List<List<Weekday>> fromSql(String fromDb) {
    final List decoded = jsonDecode(fromDb);
    return decoded.map((e) {
      final innerList = e as List;
      return innerList.map((e) => Weekday.values[e as int]).toList();
    }).toList();
  }

  @override
  String toSql(List<List<Weekday>> value) {
    return jsonEncode(
      value.map((e) => e.map((e) => e.index).toList()).toList(),
    );
  }
}

class IntListConverter extends TypeConverter<List<int>, String> {
  const IntListConverter();

  @override
  List<int> fromSql(String fromDb) {
    final List decoded = jsonDecode(fromDb);
    return decoded.cast<int>();
  }

  @override
  String toSql(List<int> value) => jsonEncode(value);
}

// extension PriorityColumn on IntColumnBuilder {
//   ColumnBuilder<int> intEnum<T extends Enum>() {
//     return map(EnumIndexConverter(Priority.values));
//   }
// }

// extension PostPolicyTypeColumn on IntColumnBuilder {
//   ColumnBuilder<int> intEnumPolicy<T extends Enum>() {
//     return map(EnumIndexConverter(PostPolicyType.values));
//   }
// }
