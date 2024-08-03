import 'package:flutter/material.dart';
import 'package:web_app/core/const/light-colors.dart';

class SnackBarComponent extends StatelessWidget {



  SnackBarComponent({super.key,
  required  this.message,
   this.messageColor=Colors.white,
  this.backgroundColor=primaryColor});

  final String message;
  final Color messageColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      backgroundColor: primaryColor,
      content:  Text(this.message,style: TextStyle(color: messageColor),),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
  }
}