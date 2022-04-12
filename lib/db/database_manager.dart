// import 'dart:async';
import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:mysql1/mysql1.dart';

abstract class AbstractDatabaseManager {
  final String? host;
  final String? user;
  final String? password;
  final String? db;
  final int? port;
  final ConnectionSettings settings;

  AbstractDatabaseManager({
    this.host,
    this.user,
    this.password,
    this.db,
    this.port,
  }) : settings = ConnectionSettings(
            host: host ?? 'beryllium.mysql.database.azure.com',
            user: user ?? 'beryllium',
            password: password ?? '1dv508project!',
            db: db ?? 'cookbook',
            port: port ?? 3306);

  void insert({
    required String table,
    required List<Map<String, dynamic>> params,
  });

  void update({
    required String table,
    required Map<String, dynamic> params,
    required String where,
  });

  void delete({
    required String table,
    required Map<String, dynamic> where,
  });

  void select({
    required String table,
    required List<String> fields,
    required Map<String, dynamic> where,
    String group,
    String having,
    List<int> limit,
  });

  void exists({
    required String table,
    required List<String> fields,
  });

  Future<void> connect();

  Future<void> close();

  Future<void> query({required String query});
}

class DatabaseManager extends AbstractDatabaseManager {
  late MySqlConnection cnx;
  late Results result;

  DatabaseManager({
    String? host,
    String? user,
    String? password,
    String? db,
  }) : super(host: host, user: user, password: password, db: db);

  @override
  Future<void> connect() async {
    try {
      cnx = await MySqlConnection.connect(settings);
    } on SocketException catch (e) {
      log("SocketException: " + e.message);
    } on TimeoutException catch (e) {
      log("TimeoutException: " + e.toString());
    }
  }

  static Future<DatabaseManager> init() async {
    DatabaseManager dbManager = DatabaseManager();
    await dbManager.connect();
    return dbManager;
  }

  @override
  Future<void> close() async {
    await cnx.close();
  }

  @override
  Future<void> query({required String query}) async {
    result = await cnx.query(query);
  }

  @override
  Future<Results?> select(
      {required String table,
      required List<String> fields,
      Map<String, dynamic>? where,
      String? group,
      String? having,
      List<int>? limit}) async {
    connect();

    String query =
        '''SELECT ${fields.length > 1 ? fields.join(", ") : fields[0]} FROM $table ''';

    if (where != null) {
      query += 'WHERE ';
      int i = 0;
      for (MapEntry entry in where.entries) {
        i++;
        query += entry.key + " = '" + entry.value + "'";
        query += i < where.length ? " AND " : "";
      }
    }
    query += ";";

    result = await cnx.query(query);

    return result;
  }

  @override
  void insert(
      {required String table, required List<Map<String, dynamic>> params}) {
    // TODO: implement insert
  }

  @override
  void delete({required String table, required Map<String, dynamic> where}) {
    // TODO: implement deleteFrom
  }

  @override
  void update(
      {required String table,
      required Map<String, dynamic> params,
      required String where}) {
    // TODO: implement update
  }

  @override
  Future<Results?> exists({
    required String table,
    required List<String> fields,
    Map<String, dynamic>? where,
  }) async {
    connect();

    String query =
        '''SELECT EXISTS(SELECT ${fields.length > 1 ? fields.join(", ") : fields[0]} FROM $table ''';

    if (where != null) {
      query += 'WHERE ';
      int i = 0;
      for (MapEntry entry in where.entries) {
        i++;
        query += entry.key + " = '" + entry.value + "'";
        query += i < where.length ? " AND " : "";
      }
    }
    query += ");";

    result = await cnx.query(query);

    return result;
  }
}
