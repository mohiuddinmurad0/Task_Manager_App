// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_flutter/data/models/login_model.dart';

//*this is the utility class for authentication to store user data in shared preferences.
//*shared preferences is used to store data locally in the device.

class AuthUtility {
  static LoginModel userInfo = LoginModel();

  //*this method is used to store user data in shared preferences.

  static Future<void> setUserInfo(LoginModel model) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    await _sharedPreferences.setString("user_data", jsonEncode(model.toJson()));
    userInfo = model;
  }

  //*this method is used to get user data from shared preferences.

  static Future<LoginModel> getUserInfo() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    String value = _sharedPreferences.getString("user_data")!;
    return LoginModel.fromJson(jsonDecode(value));
  }

  //*this method is used to clear user data from shared preferences.

  static Future<void> clearUserInfo() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    await _sharedPreferences.clear();
  }

  //*this method is used to check if user is logged in or not.

  static Future<bool> isUserLoggedIn() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    bool isLogin = _sharedPreferences.containsKey("user_data");
    if (isLogin) {
      userInfo = (await getUserInfo());
    }
    return isLogin;
  }
}
