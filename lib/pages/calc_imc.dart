import 'dart:math';

import 'package:calc_imc_dio/model/imc_model.dart';
import 'package:calc_imc_dio/repositories/imc_repository.dart';
import 'package:flutter/foundation.dart';

class CalcImc {
  ImcRepository imcRepository = ImcRepository();

  String valorImc = '';
  String valorReferencia = '';
  String altura = '';
  String peso = '';
  List<ImcModel> dataList = [];

  calculaImc({required double peso, required double altura}) async {
    if (peso <= 0 || altura <= 0) {
      valorReferencia =
          "O peso e a altura devem ser números positivos maiores que zero.";
      throw ArgumentError(
          "O peso e a altura devem ser números positivos maiores que zero.");
    }

    // Calcula o IMC
    double imc = peso / (altura * altura);
    imcRepository.save(ImcModel(Random().nextInt(1000), altura, peso, imc));

    try {
      valorImc = imc.toStringAsFixed(2);
      if (imc <= 18.5) {
        valorReferencia =
            'Isso indica que a pessoa está abaixo do peso considerado saudável para sua altura. Pode sugerir desnutrição ou outros problemas de saúde.';
      } else if (imc > 18.5 && imc <= 24.9) {
        valorReferencia =
            'Pessoas dentro dessa faixa geralmente têm um peso considerado saudável para sua altura. É o intervalo alvo para a maioria das pessoas.';
      } else if (imc > 24.9 && imc <= 29.9) {
        valorReferencia =
            'Isso indica que a pessoa está com sobrepeso, o que pode aumentar o risco de problemas de saúde, como doenças cardíacas, diabetes tipo 2 e hipertensão.';
      } else if (imc > 29.9 && imc <= 34.9) {
        valorReferencia =
            'Esta é a primeira categoria de obesidade e indica um aumento significativo no risco de problemas de saúde relacionados ao peso.';
      } else if (imc > 34.9 && imc <= 39.9) {
        valorReferencia =
            'Isso indica obesidade moderada, com um risco ainda maior de problemas de saúde.';
      } else if (imc > 39.9) {
        valorReferencia =
            'Conhecida como obesidade mórbida, esta é a categoria mais grave e apresenta o maior risco de complicações graves para a saúde.';
      }
    } catch (e) {
      valorReferencia = "Erro: $e";
    }

    return dataList;
  }
}
