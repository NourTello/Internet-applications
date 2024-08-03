import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_app/core/componant/material-button-componat.dart';
import 'package:web_app/core/componant/text_style.dart';
import 'package:web_app/core/const/light-colors.dart';
import 'package:web_app/features/files/data/repo/files_repo.dart';
import 'package:web_app/features/files/domain/bloc/files_bloc.dart';
import 'package:web_app/features/files/domain/bloc/files_event.dart';
import 'package:web_app/features/files/domain/bloc/files_state.dart';
import 'package:web_app/features/group/domain/bloc/group_event.dart';

import '../../../../core/componant/appMethod.dart';
import '../../../../core/const/string_const.dart';

// List<String> joinRequestsList = [
//   'Nour Tello',
//   'Rawan AL Masri',
// ];

groupMemberAlertDialog({
  required context,
 // required FilesBloc bloc,
  required int groupID,
}) =>
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => BlocProvider(
        create: (BuildContext context) => FilesBloc(filesRepo: FilesRepo())..add(GetGroupEvent(id: groupID)),
        child: BlocConsumer<FilesBloc, FilesState>(
          listener: (BuildContext context, FilesState state) {
            if (state is BlockUserErrorState)
              AppErrorMethod(
                  context: context,
                  title: 'Sorry',
                  msg: "You can't block this user !",
                  doSomething: () {
                    print(StringConst.somethingWrong);
                    Navigator.pop(context);
                  }
              );

            var bloc = FilesBloc.get(context);
            print("debug state :" + state.toString());
            if (state is BlockUserErrorState || state is BlockUserSuccessState)
              bloc.add(GetGroupEvent(id: groupID));
          },
          builder: (BuildContext context, FilesState state) {
            var bloc = FilesBloc.get(context);

            return AlertDialog(
              backgroundColor: backgroundColor,
              title: Text(
                'Group members ',
                style: titleTextStyle(color: thirdColor),
              ),
              actions: [
                SizedBox(
                    height: 400,
                    width: 400,
                    child: (state is GetGroupLoadingState ||
                            state is BlockUserLoadingState)
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) => Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  bloc.groupUsers[index].userName!,
                                  style: titleTextStyle(
                                      size: 15, color: thirdColor),
                                )),
                                MaterialButtonComponent(
                                  onPressed: () {
                                    bloc.add(BlockUserEvent(
                                        groupID: groupID,
                                        userID: bloc.groupUsers[index].id!));

                                  },
                                  child: Text('Block'),
                                  width: 100,
                                  containerColor: primaryColor,
                                ),
                              ],
                            ),
                            itemCount: bloc.groupUsers.length,
                          ))
              ],
            );
          },
        ),
      ),
    );
