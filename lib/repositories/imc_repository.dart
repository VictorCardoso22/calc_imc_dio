import 'package:calc_imc_dio/model/imc_model.dart';
import 'package:calc_imc_dio/repositories/imc_database.dart';

class ImcRepository {
  Future<List<ImcModel>> obterDados() async {
    List<ImcModel> listImc = [];
    var db = await ImcDatabase().obterDataBase();
    var result =
        await db.rawQuery('SELECT id, altura, peso, imc FROM imctable');

    for (var element in result) {
      listImc.add(
        ImcModel(
          int.parse(element["id"].toString()),
          double.parse(element["altura"].toString()),
          double.parse(element["peso"].toString()),
          double.parse(element["imc"].toString()),
        ),
      );
    }

    return listImc;
  }

  Future<void> save(ImcModel imcModel) async {
    var db = await ImcDatabase().obterDataBase();

    await db.rawInsert('INSERT INTO imctable (altura, peso, imc) values(?,?,?)',
        [imcModel.altura, imcModel.peso, imcModel.imc]);
  }

  Future<void> update(ImcModel imcModel) async {
    var db = await ImcDatabase().obterDataBase();

    await db.rawInsert(
        'UPDATE imctable SET altura = ?, peso = ?, imc = ? WHERE id = ? ',
        [imcModel.altura, imcModel.peso, imcModel.imc, imcModel.id]);
  }

  Future<void> delete(int id) async {
    var db = await ImcDatabase().obterDataBase();

    await db.rawInsert('DELETE FROM imctable WHERE id = ? ', [id]);
  }
}
