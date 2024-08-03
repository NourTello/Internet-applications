class JoinRequestsModel {
  bool? sucesss;
  String? msg;
  List<RequestData>? data;

  JoinRequestsModel({this.sucesss, this.msg, this.data});

  JoinRequestsModel.fromJson(Map<String, dynamic> json) {
    sucesss = json['sucesss'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <RequestData>[];
      json['data'].forEach((v) {
        data!.add(new RequestData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sucesss'] = this.sucesss;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RequestData {
  int? joinRequestId;
  int? groupId;
  int? userId;
  String? userName;
  String? email;

  RequestData(
      {this.joinRequestId,
        this.groupId,
        this.userId,
        this.userName,
        this.email});

  RequestData.fromJson(Map<String, dynamic> json) {
    joinRequestId = json['join_request_id'];
    groupId = json['group_id'];
    userId = json['user_id'];
    userName = json['user_name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['join_request_id'] = this.joinRequestId;
    data['group_id'] = this.groupId;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['email'] = this.email;
    return data;
  }
}
