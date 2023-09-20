import 'package:calc_imc_dio/model/imc_model.dart';
import 'package:calc_imc_dio/pages/calc_imc.dart';
import 'package:calc_imc_dio/repositories/imc_repository.dart';
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

  ImcRepository imcRepository = ImcRepository();

  List<ImcModel> _dados = [];

  Future<List<ImcModel>> obterIMC() async {
    _dados = await imcRepository.obterDados();
    setState(() {});
    return _dados;
  }

  @override
  void initState() {
    super.initState();
    obterIMC();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora IMC'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 60,
            ),
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
                      calc.valorImc == ''
                          ? Text(calc.valorImc)
                          : Text("Seu IMC é: ${calc.valorImc}"),
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
                FutureBuilder<List<ImcModel>>(
                  future: obterIMC(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData) {
                      final value = snapshot.data;
                      return Container(
                        color: Colors.white70,
                        height: 300,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        child: ListView.builder(
                          itemCount: value!.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onLongPress: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Deseja excluir?'),
                                  content: const Text(
                                      'apertando ok, o registro será apagado definitivamento'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          Navigator.pop(context, 'OK');
                                          imcRepository.delete(value[index].id);
                                        });
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              ),
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
                                  Text(value[index].imc.toStringAsFixed(2)),
                                  const Spacer(),
                                  Text("${value[index].peso.toString()}kg"),
                                  const Spacer(),
                                  Text("${value[index].altura.toString()}m"),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
