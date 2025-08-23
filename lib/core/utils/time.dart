import 'package:flutter/material.dart';

extension TimeExtension on TimeOfDay {
  bool isAfter(TimeOfDay o) {
    return hour > o.hour || (hour == o.hour && minute > o.minute);
  }

  bool isBefore(TimeOfDay o) {
    return hour < o.hour || (hour == o.hour && minute < o.minute);
  }
}
