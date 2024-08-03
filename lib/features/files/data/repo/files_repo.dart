import 'dart:convert';
import 'dart:developer';
import 'dart:html' as html;
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:web_app/core/const/app_const.dart';
import 'package:web_app/features/files/domain/bloc/files_state.dart';
import 'package:web_app/features/files/domain/models/my_checked_in_files_model.dart';
import '../../../../core/network/remot/end_poits.dart';
import '../../domain/models/group_model.dart';
import 'package:http/http.dart' as http;
import '../../domain/models/join_requests_model.dart';

class FilesRepo {
  Future<GroupModel> getGroup({required int id}) async {
    var request = await http.get(Uri.parse(getGroupUrl + id.toString()),
        headers: AppConst.httpHeaders());
    print("state code: ${request.statusCode}");
    if (request.statusCode == 200) {
      return GroupModel.fromJson(jsonDecode(request.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Error+${request.body}');
    }
  }

  Future<bool> uploadFile(
      {required PlatformFile file, required int groupID}) async {
    final request = await http.MultipartRequest(
        'POST', Uri.parse(uploadFileUrl + groupID.toString()))
      ..headers['Authorization'] = 'Bearer ${AppConst.token}'
      ..files.add(new http.MultipartFile("file", file.readStream!, file.size,
          filename: file.name));
    var response = await request.send();
    if (response.statusCode == 200) {
      print(response);
      return true;
    } else {
      print(response.toString());
      // AppRequest.fromJson(jsonDecode(response.toString()));
      return false;
    }
  }

  String generateUniqueFilename() {
    String baseFilename = 'my_checked_in_files'; // e.g., 'my_data'
    int randomNumber =
        Random().nextInt(100000); // Generate a 5-digit random number
    String timestamp = DateTime.now()
        .millisecondsSinceEpoch
        .toString(); // Add a timestamp for further uniqueness
    return '$baseFilename-$randomNumber-$timestamp.zip';
  }

  Future checkInFiles({required List<int> files, required int groupID}) async {
    Map<String, dynamic> data = {};
    for (int i = 0; i < files.length; i++) {
      data.addAll({"file_ids[$i]": files[i].toString()});
    }

    var request = await http.post(
        Uri.parse(checkInFilesUrl + groupID.toString()),
        headers: AppConst.httpHeaders(),
        body: data);

    print(request.statusCode);
    if (request.statusCode == 200) {
      final bytes = request.bodyBytes;
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);

      final link = html.AnchorElement(href: url)
        ..setAttribute('download', generateUniqueFilename());
      html.document.body!.append(link);
      link.click();

      html.Url.revokeObjectUrl(url);
      return true;
    }
    throw Exception(request.body);
  }

  Future<JoinRequestsModel> getJoinRequests({required int groupID}) async {
    var request = await http.get(
        Uri.parse(getJoinRequestsUrl + groupID.toString()),
        headers: AppConst.httpHeaders());
    print(request.statusCode);
    if (request.statusCode == 200)
      return JoinRequestsModel.fromJson(
          jsonDecode(request.body) as Map<String, dynamic>);
    throw Exception('Errorrrrrrrrrr : ${request.body}');
  }

  Future refuseJoinRequest({required int requestID}) async {
    var request = await http.post(
        Uri.parse(refuseJoinRequestsUrl + requestID.toString()),
        headers: AppConst.httpHeaders());
    var response = await request;
    print(response.statusCode);
    if (response.statusCode == 200)
      return true;
    else {
      print('Error : ' + response.body);
      return false;
    }
  }

  Future acceptJoinRequest({required int requestID}) async {
    var request = await http.post(
        Uri.parse(acceptJoinRequestsUrl + requestID.toString()),
        headers: AppConst.httpHeaders());
    var response = await request;
    print(response.statusCode);
    if (response.statusCode == 200)
      return true;
    else {
      print('Error : ' + response.body);
      return false;
    }
  }

  Future getMyCheckedInFiles() async {
    var request = await http.get(Uri.parse(getMyCheckedInFilesUrl),
        headers: AppConst.httpHeaders());
    var response = await request;
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      return MyCheckedInFilesModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Error : ' + response.body);
  }

  Future<bool> checkOutFile({required PlatformFile file, required int fileID}) async {
    final request = await http.MultipartRequest(
        'POST', Uri.parse(checkoutFileUrl + fileID.toString()))
      ..headers['Authorization'] = 'Bearer ${AppConst.token}'
      ..files.add(new http.MultipartFile(
          "new_file", file.readStream!, file.size,
          filename: file.name));
    var response = await request.send();
    if (response.statusCode == 200) {
      print(response);
      return true;
    } else
      return false;
  }

  Future blockUser({required int userID,required int groupID})async{
    //{{host}}/api/group/2/users/4
    var request=await http.delete(Uri.parse(blockUserFromGroupUrl+groupID.toString()+'/users/'+userID.toString()),
        headers: AppConst.httpHeaders());
    print(request.statusCode);
    print(request.body);
    if (request.statusCode==200)
      return true;
    else {
      print(request.body);
      return false;
    }

  }
}
