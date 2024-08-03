import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:web_app/core/const/app_const.dart';
import 'package:web_app/features/auth/domain/model/login_model.dart';
import 'package:web_app/features/auth/domain/model/register_model.dart';

import '../../../../core/const/string_const.dart';
import '../../../../core/network/remot/end_poits.dart';

class AuthRepo {
  Future<LoginModel> login(
      {required String email, required String password}) async {
    print(email);
    print(password);

    http.Response response =
        await http.post(Uri.parse(loginUrl), headers: <String, String>{
      'Accept': 'application/json',
    }, body: {
      "email": email,
      "password": password
    });
    print("state code: ${response.statusCode}");
    if (response.statusCode == 200) {
      log(response.body);
      return LoginModel.fromJson(jsonDecode(response.body));
    } else
      throw Exception(response.body);
  }

  Future<RegisterModel> register(
      {required String name,
      required String password,
      required String email}) async {
    var response = await http.post(
      Uri.parse(registerUrl),
      headers: <String, String>{
        'Accept': 'application/json',
      },
      body: {'name': name, 'password': password, 'email': email},
    );
    print(response.statusCode);
    if (response.statusCode == 201) {
      return RegisterModel.fromJson(jsonDecode(response.body.toString()));
    } else
      throw Exception(response.body);
  }


  Future logOut() async {
    var request =
    await http.post(Uri.parse(logOutUrl), headers: AppConst.httpHeaders());
    print(request.body);
    if (request.statusCode == 200) return true;
    return false;
  }
}

