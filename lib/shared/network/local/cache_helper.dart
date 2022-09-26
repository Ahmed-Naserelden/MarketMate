import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CachHelper {
  static late SharedPreferences sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> pushData({required key, required value}) async {
    return await sharedPreferences.setBool(key, value);
  }

  static bool? getData({required key}) {
    return sharedPreferences.getBool(key);
  }

  static Future<bool> saveData({required String key, required dynamic value}){
    if(value is int){
      return sharedPreferences.setInt(key, value);
    }
    else if(value is String){
      return sharedPreferences.setString(key, value);
    }
    else if(value is bool){
      return sharedPreferences.setBool(key, value);
    }
    return sharedPreferences.setDouble(key, value);
  }
}
