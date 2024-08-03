import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../const/light-colors.dart';


class MaterialButtonComponent extends StatelessWidget {
  const MaterialButtonComponent({
    super.key,
    this.horizontalMargin =0,
    this.verticalMargin = 16,
    this.horizontalPadding=0,
    this.verticalPadding=0,
    this.buttonHorizontalPadding = 12,
    this.buttonVerticalPadding=12,
    this.containerBorderRadius = 10,
    this.minWidth= double.infinity,
    this.containerColor=primaryColor,
    this.textColor = Colors.white,
    // this.buttonColor = Colors.transparent,
    this.elevation = 16,
    required this.onPressed,
    required this.child,
     this.text = "fff",
    this.width=double.infinity,
     this.height=40,

  });
  final double horizontalMargin;
  final double verticalMargin;
  final double verticalPadding;
  final double horizontalPadding;
  final double buttonHorizontalPadding;
  final double buttonVerticalPadding;
  // final Color buttonColor;
  final double containerBorderRadius;
  final Color? containerColor;
  final Color textColor;
  final double elevation;
  final double minWidth;
  final Function() onPressed;
  final Widget child;
  final String text;
final double width;
final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.symmetric(
          horizontal: horizontalMargin,
          vertical: verticalMargin
      ),
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontalPadding,
      ),
      decoration: BoxDecoration(
                    boxShadow: [
              BoxShadow(
                color: Colors.grey,
                //  spreadRadius: 5,
                blurRadius: 5,
                // offset: Offset(7, 5), // changes position of shadow
              ),
            ],

      borderRadius: BorderRadius.all(Radius.circular(containerBorderRadius)),
        color: containerColor??primaryColor,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        // padding: EdgeInsets.symmetric(
        //     horizontal : buttonHorizontalPadding,
        //     vertical: buttonVerticalPadding
        // ),
        textColor: textColor,
        minWidth: minWidth,
        elevation: elevation,
        child: child,
      ),
    );

//     //   child: MaterialButton(
//     //     onPressed: onPressed,
//     //     textColor: textColor,
//     //     // minWidth: minWidth,
//     //     color: buttonColor,
//     //     elevation: elevation,
//     //     child: child,
//     //
//     // // Center(
//     // // child: Text(
//     // // text.toUpperCase(),
//     // // style: TextStyle(
//     // // fontWeight: fontWeight,
//     // // color: colortext,
//     // // fontSize: fontsize,
//     // // fontFamily: 'WorkSans',
//     // //
//     // // ),
//     //   ),
//     // );
//     return
//       Center(
//       child: Container(
//           margin: EdgeInsets.symmetric(
//               horizontal: horizontalMargin,
//               vertical: verticalMargin
//           ),
//             padding: EdgeInsets.symmetric(
//               vertical: verticalPadding,
//               horizontal: horizontalPadding,
//             ),
//
//       width: 150,
//           height: 40,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             color: containerColor??primaryColor,
//
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey,
//                 //  spreadRadius: 5,
//                 blurRadius: 5,
//                 // offset: Offset(7, 5), // changes position of shadow
//               ),
//             ],
//
//           ),
//
//           child: MaterialButton(
//                 // padding: EdgeInsets.symmetric(
//                 //     horizontal : buttonHorizontalPadding,
//                 //     vertical: buttonVerticalPadding
//                 // ),
//
//           onPressed: onPressed,
//             textColor: textColor,
//             minWidth: minWidth,
// //            color: buttonColor,
//             child: Center(
//               child: Text(
//                 text.toUpperCase(),
//                 style: TextStyle(
//                     fontWeight: FontWeight.w400,
//                   color: Colors.white,
//                   fontSize: 20,
//                   fontFamily: 'WorkSans',
//
//                 ),
//               ),
//             ),
//           )),
//     );
  }
}
