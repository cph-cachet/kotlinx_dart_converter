import 'package:kotlinx_dart_converter/kotlinx_dart_converter.dart';
import 'dart:convert';

void newExampleToObject() {
  Map<String, dynamic> kotlinJson = {
    "tasks": [
      [
        "dk.cachet.carp.protocols.domain.tasks.ParallelTask",
        {
          "name": "Start All Measures",
          "measures": [
            [
              "dk.cachet.carp.protocols.domain.tasks.measures.LocationMeasure",
              {"frequency": 10000}
            ]
          ]
        }
      ]
    ]
  };

  KotlinxDartConverter jsonConverter =
      new KotlinxDartConverter();

  String outerClass = "dk.cachet.carp.protocols.domain.study.Study";
  Map<String, dynamic> protocol = jsonConverter.convert(outerClass, kotlinJson);

//  print(json.encode(protocol));

  var encoder = new JsonEncoder.withIndent("\t");
  print(encoder.convert(protocol));
}
