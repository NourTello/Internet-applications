import 'dart:core';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:web_app/core/componant/material-button-componat.dart';
import 'package:web_app/core/const/light-colors.dart';
import 'package:web_app/features/layout/domain/bloc/layout_bloc.dart';
import 'package:web_app/features/layout/domain/bloc/layout_events.dart';
import '../../../Reports/presentation/widgets/file_report_alertDialog.dart';
import '../../domain/models/group_model.dart';
class FileItem extends StatelessWidget {
   double height;
   double width;
   Files file;
   bool isSelected;
   bool isOwner;

FileItem({
     required  this.height,
  required this. width,
  required this. file,
  required this. isSelected,
  required this.isOwner,
});

  @override
  Widget build(BuildContext context) {
    {
      IconData icon;
      if (file.fileName!.endsWith('.pdf'))
        icon = Icons.picture_as_pdf;
      else if (file.fileName!.endsWith('.doc') ||
          (file.fileName!.endsWith('.docx')))
        icon = Icons.description;
// else if (path.extension(file.file.path) == ('.xls') ||
//     path.extension(file.file.path) == ('.xlsx'))
//   icon = Icons.table_chart;
      else if (file.fileName!.endsWith('.ppt') ||
          (file.fileName!.endsWith('.pptx')))
        icon = Icons.slideshow;
      else if ((file.fileName!.endsWith('.zip')) ||
          (file.fileName!.endsWith('.rar')))
        icon = Icons.archive;
      else if ((file.fileName!.endsWith('.mp3')) ||
          (file.fileName!.endsWith('.wav')))
        icon = Icons.music_note;
      else if ((file.fileName!.endsWith('.mp4')) ||
          (file.fileName!.endsWith('.avi')))
        icon = Icons.movie;
      else if (file.fileName!.endsWith('.jpg') ||
          file.fileName!.endsWith('.png') ||
          file.fileName!.endsWith('.jfif'))
        icon = Icons.image;
      else
        icon = Icons.insert_drive_file;

      return Container(
        decoration: BoxDecoration(
          color: isSelected?Colors.lightBlue.shade50:backgroundColor,
            // border: Border.all(
            //   width: 3.0,
            //   color: isSelected ? primaryColor : backgroundColor,
            // ),
            borderRadius: BorderRadius.circular(30)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon,
                color: (file.fileStatus == 1) ? lightGrey : thirdColor,
                size: width / 10),
//  SizedBox(height: 30,),
            Text(
              file.fileName!,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: file.fileStatus == 0 ? thirdColor : lightGrey,
                  fontWeight: FontWeight.w900,
                  fontSize: 20),
            ),
            Expanded(child: Center()),
            if (isOwner)
            MaterialButtonComponent(
              containerColor:Color(0xFF43766C),
              //Color(0xFF7E2553) ,
              width: 200,
                child: Text('File report'),
                onPressed:(){
                  showReportsAlertDialog(context: context,fileID:file.id!);
              })
          ],
        ),
      );
    }  }
}


