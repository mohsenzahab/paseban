extension StringCasingExtension on String {
  String get pascalCase =>
      replaceAllMapped(RegExp(r'(_|-)+(\w)'), (Match m) => m[2]!.toUpperCase())
          .capitalize();
  String get snakeCase => replaceAllMapped(
      RegExp(r'([a-z])([A-Z])'), (Match m) => '${m[1]}_${m[2]}').toLowerCase();
  String get camelCase =>
      replaceAllMapped(RegExp(r'(_|-)+(\w)'), (Match m) => m[2]!.toUpperCase())
          .decapitalize();

  String capitalize() => this[0].toUpperCase() + substring(1);
  String decapitalize() => this[0].toLowerCase() + substring(1);
}
