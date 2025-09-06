enum Weekday {
  saturday,
  sunday,
  monday,
  tuesday,
  wednesday,
  thursday,
  friday;

  int get value => switch (this) {
    Weekday.saturday => 6,

    Weekday.sunday => 7,

    Weekday.monday => 1,

    Weekday.tuesday => 2,

    Weekday.wednesday => 3,

    Weekday.thursday => 4,

    Weekday.friday => 5,
  };

  factory Weekday.fromValue(int value) {
    return switch (value) {
      6 => Weekday.saturday,

      7 => Weekday.sunday,

      1 => Weekday.monday,

      2 => Weekday.tuesday,

      3 => Weekday.wednesday,

      4 => Weekday.thursday,

      5 => Weekday.friday,
      int() => throw UnimplementedError(),
    };
  }
}
