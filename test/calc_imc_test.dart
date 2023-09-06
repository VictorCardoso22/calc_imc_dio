import 'package:calc_imc_dio/pages/calc_imc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calc_imc_dio/main.dart';

void main() {
  var calc = CalcImc();
  test('IMC calculator test', () {
    expect(calc.calculaImc(peso: 58, altura: 1.70), equals('20.07'));
    expect(
      () => calc.calculaImc(peso: 0, altura: -2),
      throwsA(
        const TypeMatcher<ArgumentError>(),
      ),
    );
  });
}
