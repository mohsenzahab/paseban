import 'package:flutter/material.dart';
import 'package:paseban/domain/models/models.dart';

class WeekdaySelector extends StatefulWidget {
  final Function(List<List<Weekday>> selectedDays) onSelectionChanged;
  final int weeksCount;
  final List<List<Weekday>>? selected;

  const WeekdaySelector({
    super.key,
    required this.onSelectionChanged,
    this.weeksCount = 1,
    this.selected,
  });

  @override
  State<WeekdaySelector> createState() => _WeekdaySelectorState();
}

class _WeekdaySelectorState extends State<WeekdaySelector> {
  late List<Set<int>> selected;

  @override
  void initState() {
    super.initState();
    updateSelected();
  }

  void updateSelected() {
    if (widget.selected == null) {
      selected = [for (int i = 0; i < widget.weeksCount; i++) {}];
    } else {
      selected = widget.selected!
          .map((e) => e.map((e) => e.index).toSet())
          .toList();
    }
  }

  @override
  void didUpdateWidget(covariant WeekdaySelector oldWidget) {
    updateSelected();
    super.didUpdateWidget(oldWidget);
  }

  void _toggleDay(int index, int week) {
    setState(() {
      if (selected[week].contains(index)) {
        selected[week].remove(index);
      } else {
        selected[week].add(index);
      }
    });
    widget.onSelectionChanged(
      selected.map((e) => e.map((e) => Weekday.values[e]).toList()).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.0,
      children: [
        for (int i = 0; i < widget.weeksCount; i++)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(Weekday.values.length, (index) {
              return ChoiceChip(
                label: Text((index + 1).toString()),
                selected: selected[i].contains(index),
                onSelected: (_) => _toggleDay(index, i),
                selectedColor: Colors.blue,
                labelStyle: TextStyle(
                  color: selected[i].contains(index)
                      ? Colors.white
                      : Colors.black,
                ),
              );
            }),
          ),
      ],
    );
  }
}
