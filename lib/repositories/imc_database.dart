import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

Map<int, String> scripts = {
  1: '''CREATE TABLE imctable (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  altura TEXT,
  peso TEXT,
  imc TEXT
);
  }
''',
};

class ImcDatabase {
  static Database? db;

  Future<Database> obterDataBase() async {
    if (db == null) {
      return await iniciarBD();
    } else {
      return db!;
    }
  }

  Future<Database> iniciarBD() async {
    var db = await openDatabase(
      path.join(await getDatabasesPath(), 'database.db'),
      version: scripts.length + 1,
      onCreate: (Database db, int version) async {
        for (var i = 1; i <= scripts.length; i++) {
          await db.execute(scripts[i]!);
        }
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        for (var i = oldVersion + 1; i <= scripts.length; i++) {
          await db.execute(scripts[i]!);
        }
      },
    );
    return db;
  }
}
