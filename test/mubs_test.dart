import 'package:test/test.dart';

import '../example/mubs_example.dart';
import '../example/mubs_example_object.dart';

void main() {
  group('A group of tests', () {

    test("MUBS Print hierarchy Example", () {
      mubsProtocolExample();
    });

    test("MUBS Object Example", () {
      mubsProtocolToObjectExample();
    });

  });
}
