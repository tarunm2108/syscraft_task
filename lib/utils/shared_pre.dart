import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPre {
  SharedPre._();

  static final instance = SharedPre._();
  static const String loginUser = 'loginUser';

  Future<bool> setString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(key, value);
  }

  Future<bool> setInt(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setInt(key, value);
  }

  Future<String> getString(String key, {String defaultValue = ''}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? defaultValue;
  }

  Future<bool> getBool(String key, {bool defaultValue = false}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? defaultValue;
  }

  Future<int> getInt(String key, {int defaultValue = -1}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? defaultValue;
  }

  Future<bool> clearAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }

  /// call this method like this
  ///  LoginData data=LoginData.fromJson(loginresponse.data.tojson())
  /// sp.setObj("",data);
  Future<bool> setObj(String key, var toJson) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = jsonEncode(toJson);
    return await prefs.setString(key, user);
  }

  /// call this method like this
  ///var data= sp.getObj("key);
  ///Login loginData= Logindata.fromjson(data);
  Future<Map<String, dynamic>> getObj(String key) async {
    Map<String, dynamic> json = {};
    try {
      if (key.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String str = prefs.getString(key) ?? "";
        if (str.isNotEmpty) {
          json = jsonDecode(str);
        }
      }
      return json;
    } catch (e) {
      return json;
    }
  }

  Future<bool> setListString(String key, List<String> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setStringList(key, data);
  }

  Future<List<String>> getListString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }
}
