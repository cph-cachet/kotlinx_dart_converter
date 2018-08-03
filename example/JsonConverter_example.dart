import 'package:JsonConverter/JsonConverter.dart';

void mubsProtocolExample() {
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
      "dk.cachet.carp.protocols.domain.triggers.TriggerWithId",
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
      "dk.cachet.carp.protocols.domain.triggers.TriggeredTask",
      {
        "triggerId": 0,
        "taskName": "Start measures",
        "targetDeviceRoleName": "Patient phone"
      }
    ]
  };

//      String s = json.encode(kotlinJson);
//      print(s);

  JsonConverter jsonConverter = new JsonConverter();
  jsonConverter.convert(kotlinJson);
}