import 'package:test/test.dart';
import '../example/new_example.dart';
import '../example/long_example.dart';
import '../example/tensor_example.dart';

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
      newExampleToObject();
    });

    test("Tensor", () {
      tensorExample();
    });
  });
}
