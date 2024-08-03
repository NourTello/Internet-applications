import 'dart:convert';
GroupListModel GroupListModelFromJson(String str) => GroupListModel.fromJson(json.decode(str));


class GroupListModel {
  String? message;
  bool? success;
  List <dynamic> groupList = [];
  // Data? data;

  GroupListModel.fromJson(Map<String, dynamic> json) {
    message  = json['msg'];
    success = json['success'];
    groupList = json ['data'];
    // data = (json['data'] as Map<String, dynamic>?) != null ? Data.fromJson(json['data'] as Map<String, dynamic>) : null;
  }

}



