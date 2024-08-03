import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_app/core/const/app_const.dart';

Future<void> saveToken(String token) async {
  await AppConst.prefs.setString('token', token).then((value) => print("token saved"));
  AppConst.token=token;
}

