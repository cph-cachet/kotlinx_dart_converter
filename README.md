# JsonConverter

#### What?
A package for converting from the Kotlin library `Kotlinx` JSON format (which supports polymorphism), 
to the Dart library `built_value`.

#### Why?
`Kotlinx` has a different representation of objects than standard JSON, and is incompatible with 
the most robust serialization library for Dart which also supports polymorphism (`built_value`).

Example can be found under `example/mubs_example.dart`