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

Future<void> showAlertDialogToAdd(context) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AddGroupDialog();
    },
  );
}


class AddGroupDialog extends StatelessWidget {
  AddGroupDialog({super.key});
  final GroupBloc categoryBloc = GroupBloc(groupRepo: GroupRepo());
  var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final GroupBloc loginBloc = GroupBloc(groupRepo: GroupRepo());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => loginBloc,
        child: BlocListener<GroupBloc, GroupState>
          (listener: (context, state) {
          if (state is AddGroupSuccessState) {
            print("done add444");
            AppSuccessMethod(
                context: context,
                msg: "Done Added Group",
                title: "Done",
                doSomething: () {
                  Navigator.pop(context);
                }
            );
            GroupBloc(groupRepo: GroupRepo()).add(GetMyGroupsEvent());
          }
          if (state is AddGroupErrorState) {
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
                      title: Text ("Add new Group",style: TextStyle(color: primaryColor,fontFamily: 'Handlee',fontSize: 25,fontWeight: FontWeight.w800)),
                      actions: [
                        Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextFieldComponent(
                                labelText: "Your task",
                                hintText: "Group name",
                                // labelStyle: TextStyle(color: darkPurple,fontSize: 20,fontWeight: FontWeight.w800,fontFamily: 'Handlee'),
                                suffixIcon: Icon(Icons.folder,
                                  color:  secondaryColor,),
                                controller: nameController,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return "This field can't be empty";
                                  }
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      context.read<GroupBloc>().add(
                                          AddGroupEvent(nameController.text));
                                      // Navigator.of(context).pop();
                                      //
                                    }

                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 20),
                                    padding: EdgeInsets.symmetric(vertical: 8,horizontal: 30),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: primaryColor
                                    ),
                                    child: Text("add",style: TextStyle(fontFamily: 'Handlee',color: Colors.white,fontWeight: FontWeight.w800,fontSize: 20)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  );
                })));

  }
}










