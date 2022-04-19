part of controllers;

class Validator {
  static Future<bool> validate({Map<String, dynamic>? userInfo}) async {
    final DatabaseManager databaseManager = await DatabaseManager.init();

    Results? res = await databaseManager.exists(table: "members", fields: [
      "*"
    ], where: {
      'email': userInfo?["email"],
      'password': userInfo?["password"]
    });

    //abolandr@gnu.org
    //xbsxysKe53
    int result = 0;

    for (var rs in res!) {
      result = rs[0];
    }
    if (result == 1) {
      return true;
    } else {
      return false;
    }
  }
}
