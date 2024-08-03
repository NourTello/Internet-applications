import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/componant/text_style.dart';
import '../../../../core/const/light-colors.dart';
import '../../domain/model/report_model.dart';

class ReportTile extends StatelessWidget {
  var data;
  ReportTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              'Action type :',
              style: titleTextStyle(color: thirdColor, size: 15),
            ),
            Expanded(child: Center()),
            Text(data['url']!.contains("check-in-file/")
                ? "Check in file"
                : data['url']!.contains("upload-file/")
                    ? "Upload file "
                    : data['url']!.contains("check-out-file/")
                        ? "Check out file "
                        : "Check in multi files"),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              "Done by : ",
              style: titleTextStyle(color: thirdColor, size: 15),
            ),
            Expanded(child: Center()),
            Text(data["user"]["name"]),
          ],
        ),
        if (!data['url']!.contains("upload-file/")&&!data['url'].contains("check-in-multi-files"))
        SizedBox(
          height: 10,
        ),
        if (!data['url']!.contains("upload-file/")&&!data['url'].contains("check-in-multi-files"))
          Row(
          children: [
            Text(
              "Old file name  : ",
              style: titleTextStyle(color: thirdColor, size: 15),
            ),
            Expanded(child: Center()),
            Expanded(child: Text(data["old_values"]["file_name"])),
          ],
        ),
        if (!data['url']!.contains("upload-file/")&&!data['url'].contains("check-in-multi-files"))
          SizedBox(
          height: 10,
        ),
        if (!data['url']!.contains("upload-file/")&&!data['url'].contains("check-in-multi-files"))
          Row(
          children: [
            Text(
              "New file name  : ",
              style: titleTextStyle(color: thirdColor, size: 15),
            ),
            Expanded(child: Center()),
            Expanded(child: Text(data["new_values"]["file_name"])),
          ],
        ),

        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              "Action date : ",
              style: titleTextStyle(color: thirdColor, size: 15),
            ),
            Expanded(child: Center()),
            Text(DateFormat.yMMMMd()
                .add_jms()
                .format(DateTime.parse(data["created_at"]))),
          ],
        ),
      ],
    );
  }
}
