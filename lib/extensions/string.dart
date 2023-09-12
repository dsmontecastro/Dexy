const String blank = "_";
const String slash = "/";
const String separator = ",";

extension MoreStrings on String {
  // Custom String Extensions

  static String nill() => blank;

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

  String capitalize() {
    List<String> list = split("");
    list[0] = list[0].toUpperCase();
    return list.join("");
  }

  // PokeAPI Specific ----------------------------------------------------------

  String form(String species) {
    //

    // Remove Species from Form Name
    String temp = replaceFirst(species, "");
    if (temp.isEmpty) return "Base";

    // Split at "-" & Capitalize each word
    List<String> list = temp.substring(1).split("-");
    list = list.map((s) => s.capitalize()).toList();
    String first = list[0];

    // Zygarde % Forms
    if (first.contains("0")) {
      list[0] += "%";
    }

    // Mega & G-Max
    else if (first == "Mega" || first == "Gmax") {
      list[0] = list[0].toUpperCase();
    }

    return list.join(" ");
  }

  String species() {
    //

    int limit = length - 1;
    List<String> list = split("");

    // Capitalize 1st Letter
    int index = 0;
    list[index] = list[index].toUpperCase();

    // Special Case: Ho-oh + Kommo-o Line
    if (contains("-o")) {
      return list.join("");
    }

    // Special Case: Nidoran-♂/♀
    else if (startsWith("nidoran-")) {
      list[limit - 1] = " ";

      if (list[limit] == "m") {
        list[limit] = "♂";
      } else {
        list[limit] = "♀";
      }
    }

    // Special Case: The Mimes
    else if (startsWith("mr") || endsWith("jr")) {
      index = indexOf("-");
      list[index] = "";

      index += 1;
      list[index] = list[index].toUpperCase();

      index = indexOf("r");
      list[index] = "r. ";
    }

    // General: Capitalize First & After-Dash
    else {
      list[index] = list[index].toUpperCase();

      // Modify "-" if Exists & Necessary
      index = list.indexOf("-", index);

      if (index > 0) {
        if (this == "type-null") {
          list[index] = ": ";
        } else if (!dashed.contains(this)) {
          list[index] = " ";
        }

        index += 1;
        list[index] = list[index].toUpperCase();
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
