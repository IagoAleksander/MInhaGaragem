import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model/carro.dart';

class DatabaseHelper {
  static final DatabaseHelper _databaseHelper = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _databaseHelper;
  }

  DatabaseHelper._internal();

  static const _databaseName = "'car_database.db'";
  static const _databaseVersion = 3;
  static const table = 'cars';
  static const columnId = 'id';
  static const columnPlaca = 'placa';
  static const columnCor = 'cor';

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnPlaca TEXT,
            $columnCor TEXT
          )
          ''');
  }

  Future insertCar(Carro car) async {
    final db = await database;

    return await db?.insert(
      table,
      car.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Carro>?> getCarList() async {
    final db = await database;

    if (db != null) {
      final List<Map<String, dynamic>> maps = await db.query(table);

      return List.generate(
        maps.length,
        (i) {
          return Carro(
            id: maps[i][columnId],
            placa: maps[i][columnPlaca],
            cor: maps[i][columnCor],
          );
        },
      );
    }
  }

  Future<void> deleteCar(int id) async {
    final db = await database;

    await db?.delete(
      table,
      where: "$columnId = ?",
      whereArgs: [id],
    );
  }
}
