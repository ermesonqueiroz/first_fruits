import 'package:first_fruits/domain/income.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'flutter_sqflite_database.db');

    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE incomes (id INTEGER PRIMARY KEY AUTOINCREMENT, value REAL NOT NULL, description TEXT NOT NULL);',
    );
  }

  Future<void> addIncome(Income income) async {
    final db = await _databaseService.database;
    await db.insert(
      'incomes',
      income.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Income>> incomes() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> incomes = await db.query(
      'incomes',
      orderBy: 'id DESC',
    );
    return List.generate(
      incomes.length,
      (index) => Income.fromMap(incomes[index]),
    );
  }
}
