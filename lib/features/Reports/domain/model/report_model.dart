class ReportModel {
  String? msg;
  bool ? success;
  List<dynamic> data = [];

  ReportModel.fromJson(Map<String, dynamic> json) {
    msg  = json['msg'];
    success = json['success'];
    data = json ['data'];
    // data = (json['data'] as Map<String, dynamic>?) != null ? Data.fromJson(json['data'] as Map<String, dynamic>) : null;
  }}

//
// class Data {
//   int? id;
//   String? userType;
//   int? userId;
//   String? event;
//   String? auditableType;
//   int? auditableId;
//   OldValues? oldValues;
//   NewValues? newValues;
//   String? url;
//   String? ipAddress;
//   String? userAgent;
//   Null? tags;
//   String? createdAt;
//   String? updatedAt;
//   User? user;
//
//   Data(
//       {this.id,
//         this.userType,
//         this.userId,
//         this.event,
//         this.auditableType,
//         this.auditableId,
//         this.oldValues,
//         this.newValues,
//         this.url,
//         this.ipAddress,
//         this.userAgent,
//         this.tags,
//         this.createdAt,
//         this.updatedAt,
//         this.user});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userType = json['user_type'];
//     userId = json['user_id'];
//     event = json['event'];
//     auditableType = json['auditable_type'];
//     auditableId = json['auditable_id'];
//     oldValues = json['old_values'] != null
//         ? new OldValues.fromJson(json['old_values'])
//         : null;
//     newValues = json['new_values'] != null
//         ? new NewValues.fromJson(json['new_values'])
//         : null;
//     url = json['url'];
//     ipAddress = json['ip_address'];
//     userAgent = json['user_agent'];
//     tags = json['tags'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_type'] = this.userType;
//     data['user_id'] = this.userId;
//     data['event'] = this.event;
//     data['auditable_type'] = this.auditableType;
//     data['auditable_id'] = this.auditableId;
//     if (this.oldValues != null) {
//       data['old_values'] = this.oldValues!.toJson();
//     }
//     if (this.newValues != null) {
//       data['new_values'] = this.newValues!.toJson();
//     }
//     data['url'] = this.url;
//     data['ip_address'] = this.ipAddress;
//     data['user_agent'] = this.userAgent;
//     data['tags'] = this.tags;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.user != null) {
//       data['user'] = this.user!.toJson();
//     }
//     return data;
//   }
// }
//
// class OldValues {
//   int? fileStatus;
//   int? checkInCount;
//   String? fileName;
//   String? fileUrl;
//   int? checkOutCount;
//
//   OldValues(
//       {this.fileStatus,
//         this.checkInCount,
//         this.fileName,
//         this.fileUrl,
//         this.checkOutCount});
//
//   OldValues.fromJson(Map<String, dynamic> json) {
//     fileStatus = json['file_status'];
//     checkInCount = json['check_in_count'];
//     fileName = json['file_name'];
//     fileUrl = json['file_url'];
//     checkOutCount = json['check_out_count'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['file_status'] = this.fileStatus;
//     data['check_in_count'] = this.checkInCount;
//     data['file_name'] = this.fileName;
//     data['file_url'] = this.fileUrl;
//     data['check_out_count'] = this.checkOutCount;
//     return data;
//   }
// }
//
// class NewValues {
//   bool? fileStatus;
//   int? checkInCount;
//   String? fileName;
//   String? fileUrl;
//   int? checkOutCount;
//   int? groupId;
//   int? id;
//
//   NewValues(
//       {this.fileStatus,
//         this.checkInCount,
//         this.fileName,
//         this.fileUrl,
//         this.checkOutCount,
//         this.groupId,
//         this.id});
//
//   NewValues.fromJson(Map<String, dynamic> json) {
//     fileStatus = json['file_status'];
//     checkInCount = json['check_in_count'];
//     fileName = json['file_name'];
//     fileUrl = json['file_url'];
//     checkOutCount = json['check_out_count'];
//     groupId = json['group_id'];
//     id = json['id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['file_status'] = this.fileStatus;
//     data['check_in_count'] = this.checkInCount;
//     data['file_name'] = this.fileName;
//     data['file_url'] = this.fileUrl;
//     data['check_out_count'] = this.checkOutCount;
//     data['group_id'] = this.groupId;
//     data['id'] = this.id;
//     return data;
//   }
// }
//
// class User {
//   int? id;
//   String? name;
//   String? email;
//   Null? emailVerifiedAt;
//   String? createdAt;
//   String? updatedAt;
//
//   User(
//       {this.id,
//         this.name,
//         this.email,
//         this.emailVerifiedAt,
//         this.createdAt,
//         this.updatedAt});
//
//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     emailVerifiedAt = json['email_verified_at'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['email_verified_at'] = this.emailVerifiedAt;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }