// @dart=2.9
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twsuser/main.dart';
import 'package:twsuser/twsuser/login.dart';

class SharedPrefManager {

  static SharedPreferences sharedPreferences;

  static savePrefString(String key,String value) async{
     sharedPreferences = await SharedPreferences.getInstance();
     sharedPreferences.setString(key, value);}

   static Future<dynamic> getPrefrenceString(String key) async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String val = prefs.getString(key);
     return val;}

   static savePreferenceBoolean(bool b) async{
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("isLoggedIn", b);}

   static getBooleanPreferences() async{
     sharedPreferences = await SharedPreferences.getInstance();
     return sharedPreferences.getBool("isLoggedIn");}

  static clearPrefs() async{
    sharedPreferences = await SharedPreferences.getInstance();
    navigatorKey.currentState.pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
    return sharedPreferences.clear();}

}