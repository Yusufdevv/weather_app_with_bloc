extension StringExtesions on String {
  String capitizeString() => '${this[0].toUpperCase()}${this.substring(1)}';
}