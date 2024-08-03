import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_app/core/componant/material-button-componat.dart';

import '../../../../core/componant/text_style.dart';
import '../../../../core/const/light-colors.dart';
import '../../data/repo/files_repo.dart';
import '../../domain/bloc/files_bloc.dart';
import '../../domain/bloc/files_event.dart';
import '../../domain/bloc/files_state.dart';

class CheckOutFileScreen extends StatelessWidget {
  const CheckOutFileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          FilesBloc(filesRepo: FilesRepo())..add(GetMyCheckedInFilesEvent()),
      child: BlocListener<FilesBloc, FilesState>(
        listener: (BuildContext context, FilesState state) {
          if (state is CheckOutFileSuccessState)
            FilesBloc.get(context).add(GetMyCheckedInFilesEvent());
        },
        child: BlocBuilder<FilesBloc, FilesState>(
            builder : (BuildContext context, FilesState state) {
          var bloc = FilesBloc.get(context);
          double width = MediaQuery.sizeOf(context).width;
          double height = MediaQuery.sizeOf(context).height;
          print('debug from screen');
          print(bloc.myCheckedInFiles.length);

          return Scaffold(
              body: (state is GetMyCheckedInFilesLoadingState||state is CheckOutFileLoadingState)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : (state is GetMyCheckedInFilesSuccessState &&
                          bloc.myCheckedInFiles.length == 0)
                      ? Center(child: Text('No checked in files !'))
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Choose a file name '),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  SizedBox(
                                    width: width / 6,
                                    child: DropdownButton(
                                      icon: Icon(
                                        Icons.file_copy_rounded,
                                      ),
                                      isExpanded: true,
                                      items: bloc.myCheckedInFiles
                                          .map((file) => DropdownMenuItem<int>(
                                              value: file.fileId,
                                              child: Text(
                                                file.fileName!,
                                                overflow: TextOverflow.ellipsis,
                                              )))
                                          .toList(),
                                      value: bloc.checkedOutFileID,
                                      onChanged: (value) {
                                        bloc.add(ChooseFileIDEvent(id: value));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MaterialButtonComponent(
                                    onPressed: () async {
                                      FilePickerResult? result =
                                          await FilePicker.platform
                                              .pickFiles(withReadStream: true);
                                      if (result != null) {
                                        bloc.add(ChooseFileEvent(
                                            file: result.files.single));
                                      }
                                    },
                                    child: Text('Choose file '),
                                    width: 120,
                                    containerColor: secondaryColor,
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  if (bloc.checkedOutFile != null)
                                    Text(bloc.checkedOutFile!.name)
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              if (bloc.checkedOutFile != null)
                                MaterialButtonComponent(
                                  width: 200,
                                    onPressed: ()=>bloc.add(CheckOutFileEvent(fileID: bloc.checkedOutFileID!, file:bloc.checkedOutFile!)),
                                    child: Text('Check out'))
                            ],
                          ),
                        ));
        },
    ))
    );
  }
}
