const String separator = ",";

extension MoreStrings on String {
  // Custom Extensions

  int getId() {
    List<String> list = split("/");
    int len = list.length - 2;
    return int.parse(list[len]);
  }

  List<int> toListInt({Pattern pattern = separator}) {
    List<String> list = split(pattern);
    return list.map(int.parse).toList();
  }
}
