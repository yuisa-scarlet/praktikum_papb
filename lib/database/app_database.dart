import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:praktikum_papb/model/user.dart';

class AppDatabase {
  static const _dbName = 'praktikum_papb.db';
  static const _dbVersion = 1;
  static const _tableUsers = 'users';

  Database? _db;

  Future<Database> get database async => _db ??= await _open();

  Future<Database> _open() async {
    final path = join(await getDatabasesPath(), _dbName);

    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableUsers (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            email TEXT NOT NULL UNIQUE,
            password_hash TEXT NOT NULL,
            created_at TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> insertUser(User user) async {
    final db = await database;
    return db.insert(_tableUsers, user.toMap());
  }

  Future<User?> findUserByEmail(String email) async {
    final db = await database;
    final rows = await db.query(
      _tableUsers,
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );
    return rows.isEmpty ? null : User.fromMap(rows.first);
  }

  Future<User?> findUserById(int id) async {
    final db = await database;
    final rows = await db.query(
      _tableUsers,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return rows.isEmpty ? null : User.fromMap(rows.first);
  }
}