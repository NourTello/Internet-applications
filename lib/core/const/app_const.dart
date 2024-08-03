import 'package:shared_preferences/shared_preferences.dart';

class AppConst {
  static const String baseUrl = 'http://127.0.0.1:8000/api';
  static String? token;

  static Map<String, String> httpHeaders() {
    return {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
  }
  static late  SharedPreferences prefs;


}
