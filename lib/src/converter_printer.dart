class KotlinxDartConverter {
  void convert(Map<String, dynamic> jsonObject) {
    unpack(jsonObject, 0);
  }

  void unpack(Map<String, dynamic> jsonObject, int tabs) {
    /// Tab-string indicates how deep into the json tree we are currently
    String tabString = makeTabs(tabs);

    jsonObject.forEach((key, value) {
      if (value is List && value.length > 0) {
        print(tabString + key);

        /// we do not know if it is only a single object or an actual array
        examineArray(value, tabs + 1);
      } else {
        print(tabString + "$key:$value");
      }
    });
  }

  void examineArray(List jsonArray, int tabs) {
    /// Tab-string indicates how deep into the json tree we are currently
    String tabString = makeTabs(tabs);

    jsonArray.forEach((item) {
      if (item is List) {
        /// Item is a polymorph object, i.e. ['string', {...}]
        split(item, tabs + 1);
      } else if (item is Map) {
        /// Item is a json map, i.e. {...}
        unpack(item, tabs++);
      } else {
        /// Item is a class name
        print(tabString + "class:$item");
        tabs++;
      }
    });
  }

  void split(List polymorphObject, int tabs) {
    /// Tab-string indicates how deep into the json tree we are currently
    String tabString = makeTabs(tabs);

    String className = polymorphObject[0];
    Map<String, dynamic> jsonObject = polymorphObject[1];
    print(tabString + "class:" + className);
    unpack(jsonObject, tabs + 1);
  }

  String makeTabs(int tabs) {
    String s = "";
    for (int i = 0; i < tabs; i++) {
      s += "\t";
    }
    return s;
  }
}