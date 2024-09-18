import 'package:flutter_test/flutter_test.dart';

///Arrange
///Act
///Assert
main() {
  late Calculator calculator;
  setUpAll(() {
    ///Arrange
    calculator = Calculator();
    print("setUp");
  });
  group("addFunction", () {
    test("Testing add method with positive", () {
      /// Act
      int result = calculator.add(2, 3);

      ///Assert
      expect(result, 6);
      print("test1");
    });
  });
  group("divide", () {
    test("Test with inputs that give int result", () {
      int result = calculator.divide(10, 5);
      expect(result, 2);
    });

    test("divide throws an error if n2 = 0", () {
      expect(() => calculator.divide(10, 0), throwsException);
    });
  });
}

class Calculator {
  int add(int n1, int n2) => n1 + n2;

  int divide(int n1, int n2) => n1 ~/ n2;
}
