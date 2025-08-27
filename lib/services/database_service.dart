import 'package:first_fruits/domain/income.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_migration/sqflite_migration.dart';

final initialScript = '''
CREATE TABLE incomes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  value REAL NOT NULL,
  description TEXT NOT NULL
);
''';

final migrations = [
  '''
  ALTER TABLE incomes
  ADD COLUMN created_at TEXT;
  ''',
  '''
  UPDATE incomes
  SET created_at = strftime("%Y-%m-%d %H:%M:%S", "now", "localtime");
  ''',
];

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

  final _migrationConfig = MigrationConfig(
    initializationScript: [initialScript],
    migrationScripts: migrations,
  );

  Future _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'flutter_sqflite_database.db');

    return await openDatabaseWithMigration(path, _migrationConfig);
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
    print(Income.fromMap(incomes[incomes.length - 1]));
    return List.generate(
      incomes.length,
      (index) => Income.fromMap(incomes[index]),
    );
  }
}
