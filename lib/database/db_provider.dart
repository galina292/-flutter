// lib/database/db_provider.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/calculation.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "calculations.db");
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE calculations (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          mass REAL NOT NULL,
          radius REAL NOT NULL,
          velocity REAL NOT NULL
        )
      ''');
    });
  }

  Future<int> createCalculation(Calculation calc) async {
    final db = await database;
    return await db.insert('calculations', calc.toMap());
  }

  Future<List<Calculation>> getAllCalculations() async {
    final db = await database;
    final maps = await db.query('calculations', orderBy: 'id DESC');
    return List.generate(maps.length, (i) => Calculation.fromMap(maps[i]));
  }
}