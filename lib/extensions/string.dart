const String separator = ",";

extension MoreStrings on String {
  // Custom Extensions

  int getId() {
    List<String> list = split("/");
    return int.parse(list[-1]);
  }

  List<int> toListInt({Pattern pattern = separator}) {
    List<String> list = split(pattern);
    return list.map(int.parse).toList();
  }
}
