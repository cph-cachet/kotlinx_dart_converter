class KotlinxDartConverter {
  /// Starts initial conversion: {kotlinx format} => {dart format}
  Map<String, dynamic> convert(Map<String, dynamic> jsonObject) {
    Map<String, dynamic> studyProtocol = unpackMap(jsonObject);
    return studyProtocol;
  }

  /// {kotlinx format} => {dart format}
  Map<String, dynamic> unpackMap(Map<String, dynamic> jsonObject) {
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

        /// Add the polymorphic object to the list of objects
        newPolymorphicList.add(polymorphicObject);
      } else if (item is String) {
        /// The WHOLE input List is polymorph array object itself,
        /// and has the form: ["className", {...}]
        polymorphicObject = splitArray(polymorphicArray);

        /// Add the polymorphic object to the list of objects
        newPolymorphicList.add(polymorphicObject);
      }
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
