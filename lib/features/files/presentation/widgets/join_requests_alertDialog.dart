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

// List<String> joinRequestsList = [
//   'Nour Tello',
//   'Rawan AL Masri',
// ];

joinRequestsAlertDialog(
        {required context,
        required int groupID,
        }) =>
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => BlocProvider(
        create: (BuildContext context)=>FilesBloc(filesRepo: FilesRepo())..add(GetJoinRequestsEvent(groupID: groupID)),
        child: BlocConsumer<FilesBloc,FilesState>(
          listener: (BuildContext context, FilesState state) {
            var bloc=FilesBloc.get(context);

            if (state is RefuseJoinRequestErrorState||state is RefuseJoinRequestSuccessState||
                state is AcceptJoinRequestSuccessState || state is AcceptJoinRequestErrorState||
            state is CheckInFilesSuccessState ||state is CheckInFilesErrorState)
              bloc.add(GetJoinRequestsEvent(groupID: groupID));
          },
          builder: (BuildContext context, FilesState state) {
            var bloc=FilesBloc.get(context);
            return AlertDialog(
              backgroundColor: backgroundColor,
              title: Text(
                'Group join requests ',
                style: titleTextStyle(color: thirdColor),
              ),
              actions: [
                SizedBox(
                    height: 400,
                    width: 400,
                    child: (state is GetGroupJoinRequestsLoadingState||state is RefuseJoinRequestLoadingState||state is AcceptJoinRequestLoadingState)
                        ? Center(
                      child: CircularProgressIndicator(),
                    )
                        : ListView.builder(
                      itemBuilder: (context, index) => Row(
                        children: [
                          Expanded(
                              child: Text(
                                bloc.joinRequests[index].userName!,
                                style: titleTextStyle(size: 15, color: thirdColor),
                              )),
                          MaterialButtonComponent(
                            onPressed: () {
                              bloc.add(RefuseJoinRequestEvent(requestID:bloc.joinRequests[index].joinRequestId!));
                            },
                            child: Text('Reject'),
                            width: 100,
                            containerColor: lightGrey,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          MaterialButtonComponent(
                            onPressed: () {
                              bloc.add(AcceptJoinRequestEvent(requestID: bloc.joinRequests[index].joinRequestId!));
                            },
                            child: Text('Accept'),
                            width: 100,
                            containerColor: primaryColor,
                          ),
                        ],
                      ),
                      itemCount: bloc.joinRequests.length,
                    ))
              ],

              // content: const Text('AlertDialog description'),
              //  actions: <Widget>[
              //    TextButton(
              //      onPressed: () => Navigator.pop(context, 'Cancel'),
              //      child: const Text('Cancel'),
              //    ),
              //    TextButton(
              //      onPressed: () => Navigator.pop(context, 'OK'),
              //      child: const Text('OK'),
              //    ),
              //  ],
            );
          },
        ),
      ),
    );
