import 'package:sqflite/sqflite.dart';
import 'package:syscraft_task/model/artist_model.dart';
import 'package:syscraft_task/model/user_model.dart';

class DBService {
  static const _databaseName = 'Syscraft.db';
  static const _databaseVersion = 1;

  ///User table details
  static const tbUser = 'tb_user';
  static const tbUserId = 'id';
  static const tbUserFirstname = 'firstname';
  static const tbUserLastname = 'lastname';
  static const tbUserEmail = 'email';
  static const tbUserPassword = 'password';
  static const tbUserDob = 'dob';
  static const tbUserHasWelcome = 'hasWelcome';
  static const tbUserSocialId = 'socialId';

  ///Artist table
  static const tbArtist = 'tb_artist';
  static const tbArtId = 'id';
  static const tbArtName = 'name';
  static const tbArtDob = 'dob';
  static const tbArtUserId = 'user_id';

  static final DBService instance = DBService._internal();

  factory DBService() => instance;

  DBService._internal();

  late Database _db;

  Future<void> init() async {
    final path = await getDatabasesPath();
    _db = await openDatabase(
      "$path/$_databaseName",
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tbUser (
            $tbUserId INTEGER PRIMARY KEY,
            $tbUserFirstname TEXT NOT NULL,
            $tbUserLastname TEXT NOT NULL,
            $tbUserEmail TEXT NOT NULL,
            $tbUserPassword TEXT NOT NULL,
            $tbUserDob TEXT NOT NULL,
            $tbUserHasWelcome INTEGER,
            $tbUserSocialId TEXT
          )
          ''');

    await db.execute('''
          CREATE TABLE $tbArtist (
            $tbArtId INTEGER PRIMARY KEY,
            $tbArtUserId INTEGER NOT NULL,
            $tbArtName TEXT NOT NULL,
            $tbArtDob TEXT NOT NULL
          )
          ''');
  }

  Future<bool> checkEmailExists(String email) async {
    String query = 'SELECT COUNT(*) FROM $tbUser WHERE $tbUserEmail = ?';
    List<Map<String, dynamic>> result = await _db.rawQuery(query, [email]);
    int? count = Sqflite.firstIntValue(result);
    return (count ?? 0) > 0;
  }

  Future<UserModel?> getUserDetails(String email, String password) async {
    String query =
        'SELECT * FROM $tbUser WHERE $tbUserEmail = ? AND $tbUserPassword = ?';
    List<Map<String, dynamic>> result =
        await _db.rawQuery(query, [email, password]);
    if (result.isNotEmpty) {
      return UserModel.fromJson(result.first);
    }
    return null;
  }

  Future<int> insertUser(UserModel user) async {
    return await _db.insert(tbUser, user.toJson());
  }

  Future<int> queryRowCount() async {
    final results = await _db.rawQuery('SELECT COUNT(*) FROM $tbUser');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  Future<int> update(UserModel user) async {
    return await _db.update(
      tbUser,
      user.toJson(),
      where: "$tbUserId = ?",
      whereArgs: [user.id],
    );
  }

  ///Artist Operation
  Future<int> insertArtist(ArtistModel artist) async {
    return await _db.insert(tbArtist, artist.toJson());
  }

  Future<List<ArtistModel>> getUserArtist(int userId) async {
    final result = await _db.query(
      tbArtist,
      where: "$tbArtUserId = ?",
      whereArgs: [userId],
    );
    return result.isNotEmpty
        ? result.map((e) => ArtistModel.fromJson(e)).toList()
        : [];
  }

  Future<int> updateArtist(ArtistModel artist) async {
    return await _db.update(
      tbArtist,
      artist.toJson(),
      where: "$tbArtId = ?",
      whereArgs: [artist.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deleteArtist(int id) async {
    return await _db.delete(
      tbArtist,
      where: '$tbArtId = ?',
      whereArgs: [id],
    );
  }
}
