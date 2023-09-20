// // import 'package:nosso_primeiro_projeto/components/task.dart';
// // import 'package:nosso_primeiro_projeto/data/database.dart';
// import 'package:sqflite/sqflite.dart';

// import '../pages/calc_imc.dart';

// class ImcDao {
//   static const String tableSql = 'CREATE TABLE $_tablename('
//       '$_imc TEXT, '
//       '$_altura TEXT, '
//       '$_peso TEXT) ';

//   static const String _tablename = 'imcTable';
//   static const String _imc = 'imc';
//   static const String _altura = 'altura';
//   static const String _peso = 'peso';

//   save(CalcImc imc) async {
//     print('Iniciando o save: ');
//     final Database bancoDeDados = await getDatabase();
//     var itemExists = await find(imc.valorImc);
//     Map<String, dynamic> imcMap = toMap(imc);
//     if (itemExists.isEmpty) {
//       print('a IMC não Existia.');
//       return await bancoDeDados.insert(_tablename, imcMap);
//     } else {
//       print('a IMC existia!');
//       return await bancoDeDados.update(
//         _tablename,
//         imcMap,
//         where: '$_imc = ?',
//         whereArgs: [imc.valorImc],
//       );
//     }
//   }

//   Map<String, dynamic> toMap(CalcImc imc) {
//     print('Convertendo to Map: ');
//     final Map<String, dynamic> mapaDeImcs = Map();
//     mapaDeImcs[_imc] = imc.valorImc;
//     mapaDeImcs[_altura] = imc.altura;
//     mapaDeImcs[_peso] = imc.peso;
//     print('Mapa de Tarefas: $mapaDeImcs');
//     return mapaDeImcs;
//   }

//   Future<List<CalcImc>> findAll() async {
//     print('Acessando o findAll: ');
//     final Database bancoDeDados = await getDatabase();
//     final List<Map<String, dynamic>> result =
//         await bancoDeDados.query(_tablename);
//     print('Procurando dados no banco de dados... encontrado: $result');
//     return toList(result);
//   }

//   List<CalcImc> toList(List<Map<String, dynamic>> mapaDeTarefas) {
//     print('Convertendo to List:');
//     final List<CalcImc> imcs = [];
//     for (Map<String, dynamic> linha in mapaDeTarefas) {
//       final CalcImc imc = CalcImc(
//         linha[_imc],
//         linha[_altura],
//         linha[_peso],
//       );
//       imcs.add(imc);
//     }
//     print('Lista de Tarefas: ${tarefas.toString()}');
//     return tarefas;
//   }

//   Future<List<Task>> find(String nomeDaTarefa) async {
//     print('Acessando find: ');
//     final Database bancoDeDados = await getDatabase();
//     print('Procurando tarefa com o nome: ${nomeDaTarefa}');
//     final List<Map<String, dynamic>> result = await bancoDeDados
//         .query(_tablename, where: '$_name = ?', whereArgs: [nomeDaTarefa]);
//     print('Tarefa encontrada: ${toList(result)}');

//     return toList(result);
//   }

//   delete(String nomeDaTarefa) async {
//     print('Deletando tarefa: $nomeDaTarefa');
//     final Database bancoDeDados = await getDatabase();
//     return await bancoDeDados.delete(
//       _tablename,
//       where: '$_name = ?',
//       whereArgs: [nomeDaTarefa],
//     );
//   }
// }
