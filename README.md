# KotlinxDartConverter

#### What?
A package for converting from the Kotlin library `Kotlinx` JSON format (which supports polymorphism), 
to the Dart library `built_value`.

#### Why?
`Kotlinx` has a different representation of objects than standard JSON, and is incompatible with 
the most robust serialization library for Dart which also supports polymorphism (`built_value`).


#### Small Example
Specifically, `Kotlinx` will represent a polymorph object as:
```
[
  "ClassName", 
  {
    "field1" : "value1", 
    "field2" : "value2",
    ...
  }
]
```

Whereas `built_value` for Dart expects the following format:

```
{
    "$" : "ClassName",
    "field1" : "value1", 
    "field2" : "value2",
    ...
}
```

#### Usage Example

```dart
Map<String, String> nonPolymorphicClasses = {
    "triggers": "dk.cachet.carp.protocols.domain.triggers.TriggerWithId",
    "triggeredTasks": "dk.cachet.carp.protocols.domain.triggers.TriggeredTask",
};

AdvancedKotlinxDartConverter jsonConverter = new AdvancedKotlinxDartConverter();
jsonConverter.nonPolymorphicClasses = nonPolymorphicClasses;
Map<String, dynamic> result = jsonConverter.convert(kotlinJson);

// Print the resulting JSON string
print(json.encode(result));
```

#### Elaborate Example (updated August 8th 2018)

Given the following Study protocol, containing both polymorphic- as well ans non-polymorphic classes:
```json
{
  "ownerId": "9c3aff68-b7f0-491a-9f1a-e2ca88bf01cf",
  "name": "MUBS",
  "masterDevices": [
    [
      "dk.cachet.carp.protocols.domain.devices.Smartphone",
      { "isMasterDevice": true, "roleName": "Patient phone" }
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
                { "category": "Location" }
              ]
            }
          ],
          [
            "dk.cachet.carp.protocols.domain.tasks.measures.StepCountMeasure",
            {
              "type": [
                "dk.cachet.carp.protocols.domain.data.StepCountDataType",
                { "category": "Movement" }
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
}
```

The converter will output the following JSON (when encoded as a string):
```json
{
  "ownerId": "9c3aff68-b7f0-491a-9f1a-e2ca88bf01cf",
  "name": "MUBS",
  "masterDevices": [
    {
      "$": "dk.cachet.carp.protocols.domain.devices.Smartphone",
      "isMasterDevice": true,
      "roleName": "Patient phone"
    }
  ],
  "connectedDevices": [],
  "connections": [],
  "tasks": [
    {
      "$": "dk.cachet.carp.protocols.domain.tasks.IndefiniteTask",
      "name": "Start measures",
      "measures": [
        {
          "$": "dk.cachet.carp.protocols.domain.tasks.measures.GpsMeasure",
          "type": [
            {
              "$": "dk.cachet.carp.protocols.domain.data.GpsDataType",
              "category": "Location"
            }
          ]
        },
        {
          "$":
            "dk.cachet.carp.protocols.domain.tasks.measures.StepCountMeasure",
          "type": [
            {
              "$": "dk.cachet.carp.protocols.domain.data.StepCountDataType",
              "category": "Movement"
            }
          ]
        }
      ]
    }
  ],
  "triggers": [
    {
      "$": "dk.cachet.carp.protocols.domain.triggers.TriggerWithId",
      "id": 0,
      "trigger": [
        {
          "$": "dk.cachet.carp.protocols.domain.triggers.StartOfStudyTrigger",
          "sourceDeviceRoleName": "Patient phone",
          "requiresMasterDevice": true
        }
      ]
    }
  ],
  "triggeredTasks": [
    {
      "$": "dk.cachet.carp.protocols.domain.triggers.TriggeredTask",
      "triggerId": 0,
      "taskName": "Start measures",
      "targetDeviceRoleName": "Patient phone"
    }
  ]
}
```