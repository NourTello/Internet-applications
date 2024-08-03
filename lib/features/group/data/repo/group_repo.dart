import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:web_app/core/const/app_const.dart';
import 'package:web_app/features/group/domain/model/group_list_model.dart';
import 'package:web_app/features/group/domain/model/my_groups_model.dart';

import '../../../../core/const/string_const.dart';
import '../../../../core/network/remot/end_poits.dart';

class GroupRepo {
  Future addGroup({required String groupName}) async {
    print(groupName);
    try {
      log("try");
      http.Response response = await http.post(Uri.parse(addGroupUrl),
          body: {"group_name": groupName}, headers: AppConst.httpHeaders());
      print("state code: ${response.statusCode}");
      if (response.statusCode == 201) {
        log("true");
        log(response.body.toString());
        return true;
      } else {
        log(response.toString());
        log("false");
        return false;
      }
    } catch (e) {
      log("catch");
      print("eroooooooooooooooooooor" + e.toString());
      return StringConst.somethingWrong;
    }
  }

  Future getAllGroups() async {
    try {
      log("try");
      http.Response response = await http.get(Uri.parse(getAllGroupsUrl),
          // body: {"group_name": groupName},
          headers: AppConst.httpHeaders());
      print("state code: ${response.statusCode}");
      if (response.statusCode == 201) {
        log("true");
        log(response.body.toString());
        Map<String, dynamic> json = jsonDecode(response.body);
        var model = GroupListModel.fromJson(json);
        print(model.success);
        return model;
      } else {
        log(response.toString());
        log("false");
        return false;
      }
    } catch (e) {
      log("catch");
      print("eroooooooooooooooooooor" + e.toString());
      return StringConst.somethingWrong;
    }
  }

  Future getMyGroups() async {
    var request = await http.get(Uri.parse(getMyGroupsUrl),
        headers: AppConst.httpHeaders());
    print(request.statusCode);
    if (request.statusCode == 200)
      return MyGroupsModel.fromJson(jsonDecode(request.body));
    throw Exception('Error : ${request.body}');
  }

  Future joinGroup({required int groupId}) async {
    try {
      log("try");
      http.Response response = await http.post(
          Uri.parse("$joinGroupRequestUrl/$groupId"),
          headers: AppConst.httpHeaders());
      print("state code: ${response.statusCode}");
      if (response.statusCode == 200) {
        log("true");
        // log(response.body.toString());
        return true;
      } else {
        log(response.toString());
        log("false");
        return false;
      }
    } catch (e) {
      log("catch");
      return false;
    }
  }
}
