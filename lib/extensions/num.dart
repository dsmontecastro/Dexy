extension Range on num {
  bool inRange(int from, int to) => (from <= this) && (this < to);
  bool inList(List<int> list) => inRange(0, list.length);
}
