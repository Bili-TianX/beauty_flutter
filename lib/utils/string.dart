final RegExp regex = RegExp(r"\d+");

Iterable<int> findNumbers(String s) {
  return regex.allMatches(s).map((m) => int.parse(m.group(0)!));
}
