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
    //

    int index = 0;
    int limit = length - 1;
    List<String> list = split("");

    // Special Case: Nidoran-♂/♀
    if (startsWith("nidoran-")) {
      list[limit - 1] = " ";

      if (list[limit] == "m") {
        list[limit] = "♂";
      } else {
        list[limit] = "♀";
      }
    }

    // Special Case: The Mimes
    else if (startsWith("mr") || endsWith("jr")) {
      list[index] = list[index].toUpperCase();

      index = indexOf("-") + 1;
      list[index] = list[index].toUpperCase();

      index = indexOf("r");
      list[index] = ". ";
    }

    // Special Case: Ho-oh + Kommo-o Line
    else if (contains("-o")) {
      list[index] = list[index].toUpperCase();
    }

    // Majority of other Pokemon
    else {
      while (index >= 0) {
        list[index] = list[index].toUpperCase();

        index = list.indexOf("-", index);
        if (this == "type-null") {
          list[index] = ": ";
        } else if (!dashed.contains(this)) {
          list[index] = " ";
        }

        index += 1;
      }
    }

    return list.join().trim();
  }

  static const dashed = [
    "porygon-z",
    "wo-chien",
    "chien-pao",
    "ting-lu",
    "chi-yu",
  ];

  //
}
