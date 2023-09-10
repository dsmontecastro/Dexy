extension Range on num {
  bool inRange(num from, num to) => (from <= this) && (this < to);
  bool inList(List<num> list) => inRange(0, list.length);
}
