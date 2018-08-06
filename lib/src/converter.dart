class JsonConverter {
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

class JsonConverterWithObject {

  /// Starts initial conversion: {kotlinx format} => {dart format}
  Map<String, dynamic> convert(Map<String, dynamic> jsonObject) {
    Map<String, dynamic> studyProtocol = unpackMap(jsonObject);
    return studyProtocol;
  }

  /// {kotlinx format} => {dart format}
  Map<String, dynamic> unpackMap(
      Map<String, dynamic> jsonObject) {
    Map<String, dynamic> newPolymorphicMap = new Map();

    jsonObject.forEach((key, value) {
      if (value is List && value.length > 0) {
        /// The object is represented as an array in Kotlinx,
        /// however the actual object could be either an array or a single object
        /// Therefore we check how many elements are in the array
        newPolymorphicMap[key] = unpackArray(value);
      } else {
        /// The field value is a simpleton, such as "field" : "fieldValue"
        /// or "field": [ ]
        newPolymorphicMap[key] = value;
      }
    });
    return newPolymorphicMap;
  }

  /// [[...], ..., [...]] => [{...}, ..., {...}]
  List<Map<String, dynamic>> unpackArray(List polymorphicArray) {
    List<Map<String, dynamic>> newPolymorphicList = new List();

    polymorphicArray.forEach((item) {
      Map<String, dynamic> polymorphicObject;
      if (item is List) {
        /// The CURRENT item is a polymorph object, i.e. ['string', {...}]
        /// and needs to be split
        polymorphicObject = splitArray(item);
      } else if (item is String) {
        /// The WHOLE input List is polymorph array object itself,
        /// and has the form: ["className", {...}]
        polymorphicObject = splitArray(polymorphicArray);
      }
      /// Add the polymorphic object to the list of objects
      newPolymorphicList.add(polymorphicObject);
    });
    return newPolymorphicList;
  }

  /// ["class", {...}] => {"$": "class", ...}
  Map<String, dynamic> splitArray(List polymorphicArray) {
    Map<String, dynamic> newPolymorphicMap = new Map();

    /// Set class name of new polymorph object
    newPolymorphicMap[r"$"] = polymorphicArray[0];

    /// Set remaining fields
    polymorphicArray[1].forEach((key, value) {
      newPolymorphicMap[key] = value;
    });

    return unpackMap(newPolymorphicMap);
  }


}
