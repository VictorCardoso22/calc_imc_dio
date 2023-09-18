import 'package:calc_imc_dio/pages/calc_imc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalcImcPage extends StatefulWidget {
  const CalcImcPage({super.key});

  @override
  State<CalcImcPage> createState() => _CalcImcPageState();
}

class _CalcImcPageState extends State<CalcImcPage> {
  CalcImc calc = CalcImc();
  final TextEditingController _alturaController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora IMC'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 60,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: _alturaController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Informe sua altura em metros, ex(1.70) ',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _pesoController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Informe seu peso ',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      calc.calculaImc(
                        altura: double.parse(_alturaController.text),
                        peso: double.parse(_pesoController.text),
                      );
                      print(calc.dataList);
                      setState(() {});
                    },
                    child: const Text("Calcular")),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 300,
                  height: 150,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDDDDDD),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(calc.valorImc),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        calc.valorReferencia,
                        softWrap: true,
                        maxLines: 4,
                        overflow: TextOverflow.fade,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: calc.dataList.length,
                    itemBuilder: (context, index) {
                      final value = calc.dataList[index];

                      return ListTile(
                        title: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("IMC:"),
                            Spacer(),
                            Text("PESO:"),
                            Spacer(),
                            Text("ALTURA:"),
                          ],
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(value['imc'].toString()),
                            const Spacer(),
                            Text(value['peso'].toString()),
                            const Spacer(),
                            Text(value['altura'].toString()),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
