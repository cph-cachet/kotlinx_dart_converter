import 'package:kotlinx_dart_converter/kotlinx_dart_converter.dart';
import 'dart:convert';

void kotlinMubsExample() {
  Map<String, dynamic> kotlinJson = {
    "ownerId": "9c3aff68-b7f0-491a-9f1a-e2ca88bf01cf",
    "name": "MUBS",
    "masterDevices": [
      [
        "dk.cachet.carp.protocols.domain.devices.Smartphone",
        {"isMasterDevice": true, "roleName": "Patient phone"}
      ]
    ],
    "connectedDevices": [],
    "connections": [],
    "tasks": [
      [
        "dk.cachet.carp.protocols.domain.tasks.IndefiniteTask",
        {
          "name": "Start measures",
          "measures": [
            [
              "dk.cachet.carp.protocols.domain.tasks.measures.GpsMeasure",
              {
                "type": [
                  "dk.cachet.carp.protocols.domain.data.GpsDataType",
                  {"category": "Location"}
                ]
              }
            ],
            [
              "dk.cachet.carp.protocols.domain.tasks.measures.StepCountMeasure",
              {
                "type": [
                  "dk.cachet.carp.protocols.domain.data.StepCountDataType",
                  {"category": "Movement"}
                ]
              }
            ]
          ]
        }
      ]
    ],
    "triggers": [
      {
        "id": 0,
        "trigger": [
          "dk.cachet.carp.protocols.domain.triggers.StartOfStudyTrigger",
          {
            "sourceDeviceRoleName": "Patient phone",
            "requiresMasterDevice": true
          }
        ]
      }
    ],
    "triggeredTasks": [
      {
        "triggerId": 0,
        "taskName": "Start measures",
        "targetDeviceRoleName": "Patient phone"
      }
    ]
  };

  Map<String, String> nonPolymorphicClasses = {
    "triggers": "dk.cachet.carp.protocols.domain.triggers.TriggerWithId",
    "triggeredTasks": "dk.cachet.carp.protocols.domain.triggers.TriggeredTask",
  };

  AdvancedKotlinxDartConverter jsonConverter = new AdvancedKotlinxDartConverter();
  jsonConverter.nonPolymorphicClasses = nonPolymorphicClasses;
  Map<String, dynamic> result = jsonConverter.convert(kotlinJson);
  
  print(json.encode(result));
}