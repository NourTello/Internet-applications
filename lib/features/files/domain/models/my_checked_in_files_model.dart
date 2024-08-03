class AppRequest {
  bool? success;
  String? msg;

  AppRequest({this.success, this.msg});

  AppRequest.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];
  }
// String toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     data['msg'] = this.msg;
//     return msg;
//   }

}







class MyCheckedInFilesModel {
  bool? success;
  String? msg;
  List<CheckedInFileData>? data;

  MyCheckedInFilesModel({this.success, this.msg, this.data});

  MyCheckedInFilesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <CheckedInFileData>[];
      json['data'].forEach((v) {
        data!.add(new CheckedInFileData.fromJson(v));
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

class CheckedInFileData {
  int? fileId;
  String? fileName;
  String? fileUrl;
  int? fileStatus;
  int? fileGroup;

  CheckedInFileData(
      {this.fileId,
        this.fileName,
        this.fileUrl,
        this.fileStatus,
        this.fileGroup});

  CheckedInFileData.fromJson(Map<String, dynamic> json) {
    fileId = json['file_id'];
    fileName = json['file_name'];
    fileUrl = json['file_url'];
    fileStatus = json['file_status'];
    fileGroup = json['file_group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file_id'] = this.fileId;
    data['file_name'] = this.fileName;
    data['file_url'] = this.fileUrl;
    data['file_status'] = this.fileStatus;
    data['file_group'] = this.fileGroup;
    return data;
  }
}
