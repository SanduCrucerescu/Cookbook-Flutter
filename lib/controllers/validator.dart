part of controllers;

class Validator {
  Future<String> validate({Map<String, dynamic>? userInfo}) async {
    final DatabaseManager databaseManager = await DatabaseManager.init();

    Results? admin = await databaseManager.exists(table: "admin", fields: [
      "*"
    ], where: {
      'email': userInfo?["email"],
    });

    Results? res = await databaseManager.exists(table: "members", fields: [
      "*"
    ], where: {
      'email': userInfo?["email"],
      'password': userInfo?["password"]
    });

    //abolandr@gnu.org
    //xbsxysKe53
    int result = 0;
    int adminRes = 0;

    for (var rs in admin!) {
      adminRes = rs[0];
    }

    for (var rs in res!) {
      result = rs[0];
    }
    if (adminRes == 1) {
      return "admin";
    } else if (result == 1) {
      return "member";
    } else {
      return "does not exist";
    }
  }

  Future<int> id(String email) async {
    final DatabaseManager databaseManager = await DatabaseManager.init();
    Results? id = await databaseManager.select(
      table: "carts",
      fields: ["id"],
      where: {"member_email": email},
    );

    int cartId = 0;

    for (var rs in id!) {
      cartId = rs[0];
    }

    return cartId;
  }
}
