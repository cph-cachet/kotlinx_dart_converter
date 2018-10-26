import 'package:kotlinx_dart_converter/kotlinx_dart_converter.dart';
import 'dart:convert';

void tensorExample() {
  Map<String, dynamic> kotlinJson = {
    "Tensors": [
      [
        "my.domain.classes.ColumnVector",
        {
          "columns": "4",
          "values": [1, 2, 3, 4]
        }
      ],
      [
        "my.domain.classes.Matrix",
        {
          "rows": "2",
          "columns": "2",
          "values": [[2, 4], [3, 6]]
        }
      ]
    ]
  };

  KotlinxDartConverter jsonConverter = new KotlinxDartConverter();
  String outerClass = "my.domain.classes.TensorCollection";
  Map<String, dynamic> result = jsonConverter.convert(outerClass, kotlinJson);

  var encoder = new JsonEncoder.withIndent("  ");
  print(encoder.convert(result));
}
