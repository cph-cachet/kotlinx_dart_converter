import 'package:test/test.dart';

import '../example/mubs_example.dart';
import '../example/mubs_example_object.dart';

void main() {
  group('A group of tests', () {

    test("MUBS Object Example", () {
      mubsProtocolToObjectExample();
    });

    test("MUBS array Example", () {
      List myArray = ["hello", "my", "name", "is",];
//      print(myArray.length);
    });



  });
}
