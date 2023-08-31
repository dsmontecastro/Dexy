const String blank = "_";
const String slash = "/";
const String separator = ",";

extension MoreStrings on String {
  // Custom String Extensions

  String nill() => blank;

  bool toBool() => this == "1" || toLowerCase() == "true";

  int getId({pattern = slash}) {
    List<String> list = split(pattern);
    int index = list.length - 2;
    int id = 0;
    if (index >= 0) id = int.parse(list[index]);
    return id;
  }

  List<int> toListInt({Pattern pattern = separator}) {
    String cleaned = replaceAll("[", "").replaceAll("]", "");
    if (isEmpty) return [];

    List<String> list = cleaned.split(pattern);
    return list.map(int.parse).toList();
  }

  String capitalize({Pattern pattern = separator}) {
    List<String> list = split("");
    list[0] = list[0].toUpperCase();
    return list.join();
  }
}
