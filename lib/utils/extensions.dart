extension StringExtensions on String {
  bool containsIgnoreCase(String string) => toLowerCase().contains(
        string.toLowerCase(),
      );

  String get capitalize =>
      "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
}
