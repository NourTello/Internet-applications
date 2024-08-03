import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:web_app/core/componant/text_style.dart';

void AppSuccessMethod({required BuildContext context,required String msg,required  String title, required void Function() doSomething,  }) {
  CoolAlert.show(
    width: 200,
    context: context,
    type: CoolAlertType.success,
    title: title?? "",
    text: msg?? "",
    titleTextStyle: titleTextStyle(size: 30),
    textTextStyle: titleTextStyle(color: Colors.black),
  onConfirmBtnTap: doSomething
  );

}
void AppErrorMethod({required BuildContext context,required String msg,required  String title, required void Function() doSomething,  }) {
  CoolAlert.show(
      width: 200,
      context: context,
      type: CoolAlertType.error,
      title: title?? "",
      text: msg?? "",
      titleTextStyle: titleTextStyle(size: 30),
      textTextStyle: titleTextStyle(color: Colors.black),
      onConfirmBtnTap: doSomething
  );

}
