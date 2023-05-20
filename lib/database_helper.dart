import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'song_player.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE songs(id INTEGER PRIMARY KEY, name TEXT)',
        );
      },
    );
  }

  Future<int> insertSong(String name) async {
    final db = await instance.database;
    return await db.insert(
      'songs',
      {'name': name},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getAllSongs() async {
    final db = await instance.database;
    return await db.query('songs');
  }
}
