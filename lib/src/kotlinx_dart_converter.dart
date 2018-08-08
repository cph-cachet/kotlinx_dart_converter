class AdvancedKotlinxDartConverter {
  Map<String, String> _nonPolymorphicClasses;

  set nonPolymorphicClasses(Map<String, dynamic> classes) => _nonPolymorphicClasses = classes;

  /// Starts initial conversion
  /// Input format: {Kotlinx format}
  /// Output format: {Dart format}
  Map<String, dynamic> convert(Map<String, dynamic> jsonObject) {
    Map<String, dynamic> studyProtocol = unpackMap(jsonObject);
    return studyProtocol;
  }

  /// Input format: {Kotlinx format}
  /// Output format: {Dart format}
  Map<String, dynamic> unpackMap(Map<String, dynamic> jsonObject) {
    Map<String, dynamic> newPolymorphicMap = new Map();

    jsonObject.forEach((key, value) {
      if (value is List && value.length > 0) {
        /// The object is represented as an array in Kotlinx,
        /// however the actual object could be either an array or a single object
        /// Therefore we check how many elements are in the array
        newPolymorphicMap[key] = unpackArray(key, value);
      } else {
        /// The field value is a simpleton, such as "field" : "fieldValue"
        /// or "field": [ ]
        newPolymorphicMap[key] = value;
      }
    });
    return newPolymorphicMap;
  }

  /// Input format: [[...], ..., ]
  /// Output format: [{...}, ...,]
  List<Map<String, dynamic>> unpackArray(String key, List polymorphicArray) {
    List<Map<String, dynamic>> newPolymorphicList = new List();

    polymorphicArray.forEach((item) {
      Map<String, dynamic> jsonObject;

      /// We are inside an array of non-polymorphic objects, i.e.
      /// [{...}, {...}]
      if (item is Map) {
        jsonObject = transformNonPolymorphicObject(key, item);
        newPolymorphicList.add(jsonObject);
      }

      else if (item is List) {
        /// The CURRENT item is a polymorph object, i.e. ['string', {...}]
        /// and needs to be split
        jsonObject = splitArray(item);

        /// Add the polymorphic object to the list of objects
        newPolymorphicList.add(jsonObject);
      }



      /// The WHOLE input List is polymorph array object itself,
      /// and has the form: ["className", {...}]
      else if (item is String) {
        jsonObject = splitArray(polymorphicArray);

        /// Add the polymorphic object to the list of objects
        newPolymorphicList.add(jsonObject);
      }


    });
    return newPolymorphicList;
  }

  /// Input format: ["class", {...}]
  /// Output format: {"$": "class", ...}
  Map<String, dynamic> splitArray(List polymorphicArray) {
    String className = polymorphicArray[0];
    Map<String, dynamic> jsonObject = polymorphicArray[1];
    return constructObjectWithNameSpace(className, jsonObject);

  }

  /// Input format: "classIdentifier", {...}
  /// Output format: {"$": "className", ...}
  Map<String, dynamic> transformNonPolymorphicObject(String key,
    Map<String, dynamic> nonPolymorphicObject) {
    Map<String, dynamic> unpackedObject = unpackMap(nonPolymorphicObject);

    String className = _nonPolymorphicClasses[key];
    return constructObjectWithNameSpace(className, unpackedObject);
  }

  /// Input format: "className", {...}
  /// Output format: {"$": "className", ...}
  Map<String, dynamic> constructObjectWithNameSpace(String className, Map<String, dynamic> jsonObject) {
    Map<String, dynamic> jsonObjectWithNameSpace = new Map();

    /// Set class name
    jsonObjectWithNameSpace[r"$"] = className;

    /// Set all fields
    jsonObject.forEach((key, value) {
      jsonObjectWithNameSpace[key] = value;
    });

    return jsonObjectWithNameSpace;
  }
}
