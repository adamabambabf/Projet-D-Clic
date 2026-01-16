import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../modele/redacteur.dart';

class DatabaseManager {
  static Future<Database> initDB() async {
    final path = join(await getDatabasesPath(), 'redacteurs.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE redacteurs(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nom TEXT,
            prenom TEXT,
            email TEXT
          )
          ''');
      },
    );
  }

  static Future<int> insertRedacteur(Redacteur r) async {
    final db = await initDB();
    return await db.insert('redacteurs', r.toMap());
  }

  static Future<List<Redacteur>> getAllRedacteurs() async {
    final db = await initDB();
    final List<Map<String, dynamic>> maps = await db.query('redacteurs');
    return List.generate(maps.length, (i) => Redacteur.fromMap(maps[i]));
  }

  static Future<int> updateRedacteur(Redacteur r) async {
    final db = await initDB();
    return await db.update(
      'redacteurs',
      r.toMap(),
      where: 'id = ?',
      whereArgs: [r.id],
    );
  }

  static Future<int> deleteRedacteur(int id) async {
    final db = await initDB();
    return await db.delete('redacteurs', where: 'id = ?', whereArgs: [id]);
  }
}
