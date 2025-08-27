import 'package:online/utils/shared_preferences/shared_pref_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{

  static Future<bool> saveToken(String? fcmToken) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(SharedPrefConst.token, fcmToken ?? "");
    return true;
  }

  static Future<String?> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(SharedPrefConst.token);
  }


  static Future<bool> setUserIsLogin(bool? login) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(SharedPrefConst.login, login ?? false);
    return true;
  }

  static Future<bool?> getUserIsLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(SharedPrefConst.login);
  }

  static Future<bool> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
    return true;
  }
}