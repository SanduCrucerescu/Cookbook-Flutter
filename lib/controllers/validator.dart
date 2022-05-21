part of controllers;

class Validator {
  static Future<String> validate({Map<String, dynamic>? userInfo}) async {
    final DatabaseManager dbManager = await DatabaseManager.init();

    Results? admin = await dbManager.exists(table: "admin", fields: [
      "*"
    ], where: {
      'email': userInfo?["email"],
    });

    Results? res = await dbManager.exists(table: "members", fields: [
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

  static Future<Map<String, dynamic>> userData(String email) async {
    final dbManager = await DatabaseManager.init();
    Results? userData = await dbManager.select(
      table: 'members',
      fields: ['username', 'cart_id', 'profile_pic'],
      where: {'email': email},
    );

    final fields = userData!.first.fields;

    return {
      'username': fields['username'],
      'cartID': fields['cart_id'],
      'profilePic': fields['profile_pic'],
    };
  }

  static Future<int> id(String email) async {
    final DatabaseManager dbManager = await DatabaseManager.init();
    Results? id = await dbManager.select(
      table: "carts",
      fields: ["id"],
      where: {"member_email": email},
    );

    return id!.first.fields['id'];
  }
}
