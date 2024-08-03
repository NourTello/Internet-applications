class GroupModel {
  bool? success;
  String? msg;
  Data? data;

  GroupModel({this.success, this.msg, this.data});

  GroupModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? groupId;
  String? groupName;
  int? groupOwner;
  bool? isOwner;
  List<Files>? files;
  List<GroupUsers>? groupUsers;

  Data(
      {this.groupId,
        this.groupName,
        this.groupOwner,
        this.isOwner,
        this.files,
        this.groupUsers});

  Data.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    groupName = json['group_name'];
    groupOwner = json['group_owner'];
    isOwner = json['is_owner'];
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(new Files.fromJson(v));
      });
    }
    if (json['group_users'] != null) {
      groupUsers = <GroupUsers>[];
      json['group_users'].forEach((v) {
        groupUsers!.add(new GroupUsers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_id'] = this.groupId;
    data['group_name'] = this.groupName;
    data['group_owner'] = this.groupOwner;
    data['is_owner'] = this.isOwner;
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    if (this.groupUsers != null) {
      data['group_users'] = this.groupUsers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Files {
  int? id;
  String? fileName;
  String? fileUrl;
  int? fileStatus;
  int? checkInCount;
  int? checkOutCount;

  Files(
      {this.id,
        this.fileName,
        this.fileUrl,
        this.fileStatus,
        this.checkInCount,
        this.checkOutCount});

  Files.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fileName = json['file_name'];
    fileUrl = json['file_url'];
    fileStatus = json['file_status'];
    checkInCount = json['checkIn_count'];
    checkOutCount = json['checkOut_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['file_name'] = this.fileName;
    data['file_url'] = this.fileUrl;
    data['file_status'] = this.fileStatus;
    data['checkIn_count'] = this.checkInCount;
    data['checkOut_count'] = this.checkOutCount;
    return data;
  }
}

class GroupUsers {
  int? id;
  String? userName;
  String? userEmail;
  int? checkInAction;
  int? checkOutAction;

  GroupUsers(
      {this.id,
        this.userName,
        this.userEmail,
        this.checkInAction,
        this.checkOutAction});

  GroupUsers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    checkInAction = json['check_in_action'];
    checkOutAction = json['check_out_action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_name'] = this.userName;
    data['user_email'] = this.userEmail;
    data['check_in_action'] = this.checkInAction;
    data['check_out_action'] = this.checkOutAction;
    return data;
  }
}
