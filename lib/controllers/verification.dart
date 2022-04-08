import 'dart:developer';

class Validator {
  static bool validate({Map<String, dynamic>? userInfo}) {
    if (userInfo == null) {
      log("input is null");
      return false;
    }
    return userInfo["username"] == "manu";
  }
}
