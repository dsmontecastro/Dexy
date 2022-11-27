extension Range on num {
  bool inRange(int from, int to) => (from <= this) && (this < to);
}
