import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Create User table
        await db.execute(
            '''
          CREATE TABLE User (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            password TEXT
          )
          '''
        );

        // Create Customer table with a foreign key referencing the User table
        await db.execute(
            '''
          CREATE TABLE Customer (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userId INTEGER,
            name TEXT,
            phone TEXT,
            FOREIGN KEY(userId) REFERENCES User(id)
          )
          '''
        );
      },
    );
  }

  // Insert a new user
  Future<int> insertUser(Map<String, dynamic> user) async {
    Database db = await database;
    return await db.insert('User', user);
  }

  // Get a user by username and password
  Future<Map<String, dynamic>?> getUser(String username, String password) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'User',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  // Insert a new customer linked to a specific user
  Future<int> insertCustomer(int userId, Map<String, dynamic> customer) async {
    Database db = await database;
    customer['userId'] = userId;
    return await db.insert('Customer', customer);
  }

  // Get customers for a specific user
  Future<List<Map<String, dynamic>>> getCustomersForUser(int userId) async {
    Database db = await database;
    return await db.query('Customer', where: 'userId = ?', whereArgs: [userId]);
  }
}
