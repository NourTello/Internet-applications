import 'package:flutter/material.dart';

import '../const/light-colors.dart';


class TextFieldComponent extends StatelessWidget {
  TextFieldComponent(
      {Key? key,
        this.contentHorizontalPadding = 16,
        this.contentVerticalPadding = 16,
        this.horizontalPadding = 0,
        this.verticalPadding = 0,
        this.textAlign = TextAlign.start,
        this.onTap,
        this.controller,
        this.textInputType,
        this.validate,
        this.floatingLabelBehavior,
        this.labelText,
        this.prefixIcon,
        this.border,
        this.initValue,
        this.onPressed,
        this.onChanged,
        this.labelSize,
        this.enabled = true,
        this.obscureText=false,
        this.maxLines=1,
        this.hintText,
        this.suffixIcon,
        this.helpText,
      })
      : super(key: key);

  final GestureTapCallback? onTap;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final FormFieldValidator<String>? validate;
  final bool obscureText;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final InputBorder? border;
  final String? initValue;
  final VoidCallback? onPressed;
  final bool enabled;
  final TextInputAction? action = TextInputAction.next;
  final Function(String)? onChanged;
  final double? labelSize;
  final double verticalPadding;
  final double horizontalPadding;
  final double contentVerticalPadding;
  final double contentHorizontalPadding;
  final TextAlign textAlign;
  final int? maxLines;
  final String? hintText;
  final String? helpText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding , vertical:verticalPadding ),
      child: TextFormField(
      //  minLines: 2,
        textAlign: textAlign,
        textInputAction: action,
        enabled: enabled,
        initialValue: initValue,
        onTap: onTap,
        controller: controller,
        keyboardType: textInputType,
        validator: validate,
        obscureText: obscureText,
        onChanged: onChanged,
        maxLines: obscureText ? 1 : maxLines,
        decoration: InputDecoration(
          helperText : helpText,

          hintText: hintText,
          floatingLabelBehavior: floatingLabelBehavior,
          contentPadding: EdgeInsets.symmetric(vertical: contentVerticalPadding, horizontal: contentHorizontalPadding),
          // labelText: labelText,
          // labelStyle: TextStyle(color: Colors.grey,fontFamily: 'Handlee',fontSize: 20,),

          hintStyle: TextStyle(
          color: darkGrey,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis,
        ),

          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          //  //  borderSide: BorderSide(color: PmainColor),
          //  // borderSide: BorderSide(width: 3,color: primaryColor),
          // ),
          // disabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.all(Radius.circular(16)),
          //   borderSide: BorderSide(width: 1, color:  darkGrey!),
          // ),
          // errorBorder:  OutlineInputBorder(
          //   borderRadius: BorderRadius.all(Radius.circular(16)),
          //   borderSide: BorderSide(width: 2, color: errorColor),
          // ),
          focusedErrorBorder: OutlineInputBorder(

            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(width: 2, color: errorColor),
          ),
          // enabledBorder:  OutlineInputBorder(
          //
          //   borderRadius: BorderRadius.circular(10),
          //   borderSide: BorderSide(width:2, color: darkGrey!),
          // ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,

        ),
      ),
    );
  }
}