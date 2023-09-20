import 'package:calc_imc_dio/repositories/imc_database.dart';
import 'package:flutter/material.dart';

import 'pages/calc_imc_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ImcDatabase().iniciarBD();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const CalcImcPage(),
    );
  }
}
