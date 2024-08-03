import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_app/core/const/app_const.dart';
import 'package:web_app/core/const/light-colors.dart';
import 'package:web_app/core/const/string_const.dart';
import 'package:web_app/features/group/data/repo/group_repo.dart';
import '../../../../core/componant/app-text-field.dart';
import '../../../../core/componant/appMethod.dart';
import '../../domain/bloc/group_bloc.dart';
import '../../domain/bloc/group_event.dart';
import '../../domain/bloc/group_state.dart';

Future<void> showAlertDialogToJoin(context,int groupId) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return JoinGroupDialog(groupId:groupId);
    },
  );
}


class JoinGroupDialog extends StatelessWidget {
  JoinGroupDialog({super.key, required this.groupId});
  final int groupId;
  final GroupBloc categoryBloc = GroupBloc(groupRepo: GroupRepo());
  var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final GroupBloc groupBloc = GroupBloc(groupRepo: GroupRepo());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => groupBloc,
        child: BlocListener<GroupBloc, GroupState>
          (listener: (context, state) {
          if (state is JoinGroupRequestSuccessState) {
            print("done send");
            AppSuccessMethod(
                context: context,
                msg: "Done send request",
                title: "Done",
                doSomething: () {
                  Navigator.pop(context);
                }
            );
          }
          if (state is JoinGroupRequestErrorState) {
            print('error');
            AppErrorMethod(
                context: context,
                title: 'Sorry',
                msg: StringConst.somethingWrong,
                doSomething: () {
                  print(StringConst.somethingWrong);
                  Navigator.pop(context);
                }
            );
          }
        },
            child: BlocBuilder<GroupBloc, GroupState>(
                builder: (context, state) {
                  return  Container(
                    child: AlertDialog(
                      title: Text ("Send Join Requset",style: TextStyle(color: primaryColor,fontFamily: 'Handlee',fontSize: 25,fontWeight: FontWeight.w800)),
                      actions: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Are you sure you want to send join request to this group??'),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                    context.read<GroupBloc>().add(
                                        JoinGroupRequestEvent(groupId));
                                    // Navigator.of(context).pop();
                                    //

                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 20),
                                  padding: EdgeInsets.symmetric(vertical: 8,horizontal: 30),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: primaryColor
                                  ),
                                  child: Text("send",style: TextStyle(fontFamily: 'Handlee',color: Colors.white,fontWeight: FontWeight.w800,fontSize: 20)),
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  );
                })));

  }
}










