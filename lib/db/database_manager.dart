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

    /// cnx = mysql.connector.connect(user="beryllium", password="{your_password}", host="", port=3306, database="{your_database}", ssl_ca="{ca-cert filename}", ssl_disabled=False)
  }) : settings = ConnectionSettings(
            host: host ?? 'beryllium2nd.mysql.database.azure.com',
            user: user ?? 'beryllium',
            password: password ?? '1dv508project!',
            db: db ?? 'cookbook',
            port: port ?? 3306);

  void insert(
      {required String table,
      required List<String> fields,
      required Map<String, dynamic> data});

  void update({
    required String table,
    required Map<String, dynamic> where,
    required Map<String, dynamic> set,
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

  void query({required String query});
}

class DatabaseManager extends AbstractDatabaseManager {
  MySqlConnection? cnx;
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
    await cnx?.close();
  }

  @override
  Future<Results?> query({required String query}) async {
    await connect();
    print(query);
    result = await cnx!.query(query);
    return result;
  }

  @override
  Future<Results?> select(
      {required String table,
      required List<String> fields,
      Map<String, dynamic>? where,
      bool? and,
      bool? or,
      String? group,
      String? having,
      List<int>? limit}) async {
    // connect();
    await connect();
    String query =
        '''SELECT ${fields.length > 1 ? fields.join(", ") : fields[0]} FROM $table ''';

    if (where != null) {
      query += 'WHERE ';
      int i = 0;
      for (MapEntry entry in where.entries) {
        i++;
        query += entry.key + " = '" + entry.value + "'";
        if (and == true) {
          query += i < where.length ? " AND " : "";
        } else if (or == true) {
          query += i < where.length ? " OR " : "";
        }
      }
    }
    query += ";";

    result = await cnx!.query(query);
    await cnx!.close();
    return result;
  }

  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  Future<Results?> insert(
      {required String table,
      required List<String> fields,
      required Map<String, dynamic> data}) async {
    await connect();
    String query = '''
            INSERT INTO $table (${fields.length > 1 ? fields.join(", ") : fields[0]}) VALUES (''';
    int i = 0;
    for (MapEntry entry in data.entries) {
      i++;
      //query += i < data.length ? "'" + entry.value + "'" : entry.value;
      query += isNumeric(entry.value.toString())
          ? entry.value.toString()
          : "'" + entry.value + "'";
      query += i < data.length ? "," : "";
    }
    query += ");";

    result = await cnx!.query(query);

    await cnx!.close();
    return result;
  }

  @override
  Future<Results?> delete(
      {required String table, required Map<String, dynamic> where}) async {
    await connect();

    String query = '''
    DELETE FROM $table WHERE
      ''';
    int i = 0;
    for (MapEntry entry in where.entries) {
      i++;
      query += entry.key + " = " + "'" + entry.value.toString() + "'";
      query += i < where.length ? " AND " : "";
    }

    query += ";";
    result = await cnx!.query(query);
    await cnx!.close();
    return result;
  }

  @override
  Future<Results?> update(
      {required String table,
      required Map<String, dynamic> where,
      required Map<String, dynamic> set}) async {
    if (cnx == null) await connect();

    String query = '''UPDATE  $table SET ''';
    int i = 0;
    for (MapEntry entry in set.entries) {
      i++;
      query += entry.key + " = " + "'" + entry.value + "'";
      query += i < set.length ? " , " : "";
    }
    for (MapEntry entry in where.entries) {
      query += " WHERE " + entry.key + " = " + entry.value;
    }

    query += ";";

    result = await cnx!.query(query);
    await cnx!.close();
    return result;
  }

  @override
  Future<Results?> exists({
    required String table,
    required List<String> fields,
    Map<String, dynamic>? where,
  }) async {
    await connect();

    String query =
        '''SELECT EXISTS(SELECT ${fields.length > 1 ? fields.join(", ") : fields[0]} FROM $table ''';

    if (where != null) {
      query += 'WHERE ';
      int i = 0;
      for (MapEntry entry in where.entries) {
        i++;
        query += entry.key + " = '" + entry.value.toString() + "'";
        query += i < where.length ? " AND " : "";
      }
    }
    query += ");";

    result = await cnx!.query(query);
    await cnx!.close();
    return result;
  }
}
