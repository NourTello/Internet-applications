
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_app/features/group/presentation/widgets/show_dialog_to_join_group.dart';

import '../../../../core/const/light-colors.dart';
import '../../../files/presentation/screens/files_screen.dart';
import '../../domain/bloc/group_bloc.dart';
import '../../domain/bloc/group_event.dart';

class GroupTile extends StatelessWidget {
  double width;
  String name;
  bool userIn;
  int id;
  Function() onTab;
  GroupTile({
    super.key,
    required this.width,
    required this.name,
    required this.userIn,
    required this.id,
    required this.onTab
  });


  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap:(userIn)? onTab:(){
          showAlertDialogToJoin(context,id);
        },

        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Icon( Icons.folder, color:  secondaryColor, size: width / 10,),
                if(!userIn)
                  Icon(Icons.lock,size: width / 30)
              ],
            ),
            //  SizedBox(height: 30,),
            Text(
                name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color:  thirdColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 20),
            ),
          ],
        )
    );
  }
}
