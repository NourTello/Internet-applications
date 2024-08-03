class MyGroupsModel {
  bool? success;
  String? msg;
  List<GroupData>? data;

  MyGroupsModel({this.success, this.msg, this.data});

  MyGroupsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <GroupData>[];
      json['data'].forEach((v) {
        data!.add(new GroupData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GroupData {
  int? groupId;
  String? groupName;
  int? groupOwner;
  GroupUsers? groupUsers;

  GroupData({this.groupId, this.groupName, this.groupOwner, this.groupUsers});

  GroupData.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    groupName = json['group_name'];
    groupOwner = json['group_owner'];
    groupUsers = json['group_users'] != null
        ? new GroupUsers.fromJson(json['group_users'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_id'] = this.groupId;
    data['group_name'] = this.groupName;
    data['group_owner'] = this.groupOwner;
    if (this.groupUsers != null) {
      data['group_users'] = this.groupUsers!.toJson();
    }
    return data;
  }
}

class GroupUsers {
  String? userName;
  String? email;

  GroupUsers({this.userName, this.email});

  GroupUsers.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['email'] = this.email;
    return data;
  }
}
