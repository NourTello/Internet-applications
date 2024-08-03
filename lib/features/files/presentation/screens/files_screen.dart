import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_app/core/componant/text_style.dart';
import 'package:web_app/core/const/light-colors.dart';
import 'package:web_app/features/files/domain/bloc/files_bloc.dart';
import 'package:web_app/features/files/domain/bloc/files_event.dart';
import 'package:web_app/features/files/domain/bloc/files_state.dart';
import 'package:web_app/features/files/domain/models/file_model.dart';
import 'package:web_app/features/files/presentation/widgets/group_users_alertDialog.dart';
import 'package:web_app/features/files/presentation/widgets/join_requests_alertDialog.dart';
import 'package:web_app/features/layout/domain/bloc/layout_events.dart';

import '../../../../core/componant/material-button-componat.dart';
import '../../../layout/domain/bloc/layout_bloc.dart';
import '../../data/repo/files_repo.dart';
import '../../domain/models/group_model.dart';
import '../widgets/file_item.dart';

class FilesScreen extends StatelessWidget {
  FilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int groupID = LayoutBloc.get(context).currentGroupID;

    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return BlocProvider(
      create: (BuildContext context) =>
          FilesBloc(filesRepo: FilesRepo())..add(GetGroupEvent(id: groupID)),
      child: BlocConsumer<FilesBloc, FilesState>(
        listener: (BuildContext context, FilesState state) {
          var bloc = FilesBloc.get(context);
          if (state is UploadFileSuccessState ||
              state is UploadFileErrorState ||
              state is CheckInFilesErrorState ||
              state is CheckInFilesSuccessState ||
              state is AcceptJoinRequestSuccessState||
          state is BlockUserSuccessState)
            bloc.add(GetGroupEvent(id: groupID));
        },
        builder: (BuildContext context, FilesState state) {
          var bloc = FilesBloc.get(context);
          return !(state is GetGroupLoadingState ||
                  state is UploadFileLoadingState)
              ? Scaffold(
                  appBar: AppBar(
                    backgroundColor: backgroundColor,
                    elevation: 0,
                    actions: [
                      (bloc.isGroupOwner)
                          ? PopupMenuButton(
                              itemBuilder: (BuildContext context) {
                                return [
                                  PopupMenuItem(
                                    child: Text('Join requests'),
                                    value: 1,
                                  ),
                                  // PopupMenuItem(
                                  //   child: Text('Group reports'),
                                  //   value: 2,
                                  // ),
                                  PopupMenuItem(
                                    child: Text('Group members'),
                                    value: 2,
                                  ),
                                ];
                              },
                              onSelected: (value) {
                                print('Selected: $value');
                                if (value == 1)
                                  joinRequestsAlertDialog(
                                      context: context, groupID: groupID);
                                else if (value == 2)
                                  groupMemberAlertDialog(
                                      groupID: groupID,
                                      context: context);
                              },
                            )
                          : Container()
                    ],
                    // title:(bloc.isGroupOwner)? Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Container(
                    //       width: 200,
                    //       child: TextButton(
                    //         child: Row(
                    //           children: [
                    //             Text('Join requests',
                    //                 style: titleTextStyle(color: thirdColor)),
                    //             SizedBox(
                    //               width: 10,
                    //             ),
                    //             Icon(Icons.group_add, color: thirdColor)
                    //           ],
                    //         ),
                    //         onPressed: () {
                    //           joinRequests(context: context,groupID: groupID);
                    //         },
                    //       ),
                    //     )):Container()
                  ),
                  floatingActionButton: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      MaterialButtonComponent(
                        onPressed: () async {
                          FilePickerResult? result = await FilePicker.platform
                              .pickFiles(withReadStream: true);
                          if (result != null) {
                            PlatformFile objFile = result.files.single;
                            bloc.add(
                                UploadFileEvent(id: groupID, file: objFile));
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Upload a file '),
                            Icon(Icons.upload)
                          ],
                        ),
                        width: 170,
                        containerColor: secondaryColor,
                      ),
                      MaterialButtonComponent(
                        onPressed: () {
                          bloc.add(CheckInFilesEvent(
                              groupID: groupID, files: bloc.selectedFilesID));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Check in selected files '),
                            Icon(Icons.download_rounded)
                          ],
                        ),
                        width: 250,
                      ),
                      // MaterialButtonComponent(
                      //   onPressed: () {
                      //     CheckOutFile(context: context);
                      //     },
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Text('Checkout a file  '),
                      //       Icon(Icons.file_open_rounded)
                      //     ],
                      //   ),
                      //   width: 250,
                      // ),
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: [
                        GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 6,
                              crossAxisSpacing: 20,
                              mainAxisExtent: height / 2.6,
                              mainAxisSpacing: 20,
                            ),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  (bloc.groupFiles[index].fileStatus == 0)
                                      ? context.read<FilesBloc>().add(
                                          SelectFileEvent(
                                              index: index,
                                              id: bloc.groupFiles[index].id!))
                                      : null;
                                },
                                child: FileItem(
                                  isOwner: bloc.isGroupOwner,
                                  height: height,
                                  width: width,
                                  file: bloc.groupFiles[index],
                                  isSelected:
                                      bloc.selectedFilesIndexes.contains(index),
                                )),
                            itemCount: bloc.groupFiles.length),
                      ],
                    ),
                  ),
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
