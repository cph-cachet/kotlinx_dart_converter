import 'package:test/test.dart';

import '../example/mubs_example.dart';
import '../example/mubs_example_object.dart';
import '../example/new_example.dart';
import '../example/kotlin_example.dart';

void main() {
  group('A group of tests', () {
//
//    test("MUBS Print hierarchy Example", () {
//      mubsProtocolExample();
//    });
//
//    test("MUBS Object Example", () {
//      mubsProtocolToObjectExample();
//    });

    test("True Kotlinx Example", () {
      kotlinMubsExample();
    });
  });
}
