import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:web_app/core/const/app_const.dart';
import 'package:web_app/core/network/remot/end_poits.dart';
import 'package:web_app/features/Reports/domain/model/report_model.dart';

class ReportsRepo {
  Future<ReportModel> getReport({required int fileID})async{
    var request=await http.get(Uri.parse(getFileReportUrl+fileID.toString()),headers: AppConst.httpHeaders());
    print(request.statusCode);
    if (request.statusCode==200)
      return ReportModel.fromJson(jsonDecode(request.body));
    else
      throw Exception(request.body);
  }


}
