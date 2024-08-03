import 'dart:async';
import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_app/core/network/remot/end_poits.dart';
import 'package:web_app/features/files/domain/bloc/files_event.dart';
import 'package:web_app/features/files/domain/bloc/files_state.dart';
import 'package:web_app/features/files/domain/models/group_model.dart';
import 'package:web_app/features/files/domain/models/my_checked_in_files_model.dart';
import 'package:web_app/features/files/presentation/widgets/join_requests_alertDialog.dart';

import '../../data/repo/files_repo.dart';
import '../models/join_requests_model.dart';

class FilesBloc extends Bloc<FilesEvent, FilesState> {
  FilesRepo filesRepo;
  FilesBloc({required this.filesRepo}) : super(FilesInitialState()) {
    on<SelectFileEvent>(selectFile);
    on<GetGroupEvent>(getGroup);
    on<UploadFileEvent>(uploadFile);
    on<CheckInFilesEvent>(checkInFiles);
    on<GetJoinRequestsEvent>(getJoinRequests);
    on<RefuseJoinRequestEvent>(refuseJoinRequest);
    on<AcceptJoinRequestEvent>(acceptJoinRequest);
    on<GetMyCheckedInFilesEvent>(getMyCheckedInFiles);
    on<ChooseFileEvent>(chooseFile);
    on<ChooseFileIDEvent>(chooseFileID);
    on<CheckOutFileEvent>(checkOutFile);
    on<BlockUserEvent>(blockUser);
  }
  static FilesBloc get(context) => BlocProvider.of(context);
  List<int> selectedFilesID = [];
  List<int> selectedFilesIndexes = [];
  List<Files> groupFiles = [];
  List<RequestData> joinRequests = [];
  List<CheckedInFileData> myCheckedInFiles = [];
  bool isGroupOwner = false;
  List<GroupUsers>groupUsers=[];

  selectFile(SelectFileEvent event, Emitter<FilesState> emit) {
    if (selectedFilesIndexes.contains(event.index)) {
      selectedFilesIndexes.remove(event.index);
      selectedFilesID.remove(event.id);
    } else {
      selectedFilesIndexes.add(event.index);
      selectedFilesID.add(event.id);
    }
    emit(SelectFileState());
  }

  FutureOr<void> getGroup(GetGroupEvent event, Emitter<FilesState> emit) async {
    emit(GetGroupLoadingState());
    groupFiles = [];
    GroupModel response = await filesRepo.getGroup(id: event.id);
    print(response.msg);
    if (response.success!) {
      isGroupOwner = response.data!.isOwner!;
      if(isGroupOwner)
        groupUsers=response.data!.groupUsers!;

      groupFiles = response.data!.files!;
      emit(GetGroupSuccessState(groupFilesList: response.data!.files!));
      print(response.msg);
      print(response.data!.toJson());
    } else
      emit(GetGroupErrorState(errorMessage: response.msg!));
  }

  FutureOr<void> uploadFile(
      UploadFileEvent event, Emitter<FilesState> emit) async {
    emit(UploadFileLoadingState());
    bool response =
        await filesRepo.uploadFile(file: event.file, groupID: event.id);
    if (response != null) {
      print(response);
      if (response)
        emit(UploadFileSuccessState());
      else
        emit(UploadFileErrorState(errorMessage: ""));
    }
  }

  FutureOr<void> checkInFiles(
      CheckInFilesEvent event, Emitter<FilesState> emit) async {
    emit(CheckInFilesLoadingState());
    bool response = await filesRepo.checkInFiles(
        files: event.files, groupID: event.groupID);
    if (response != null) {
      if (response)
        emit(CheckInFilesSuccessState());
      else
        emit(CheckInFilesErrorState());
      selectedFilesID = [];
      selectedFilesIndexes = [];
    }
  }

  FutureOr<void> getJoinRequests(
      GetJoinRequestsEvent event, Emitter<FilesState> emit) async {
    emit(GetGroupJoinRequestsLoadingState());
    joinRequests = [];
    JoinRequestsModel request =
        await filesRepo.getJoinRequests(groupID: event.groupID);
    JoinRequestsModel response = await request;

    if (response != null) {
      print(response.msg);
      if (response.sucesss!) {
        joinRequests = response.data!;
        emit(GetGroupJoinRequestsSuccessState());
        print(response.toJson());
      } else
        emit(GetGroupJoinRequestsErrorState());
    }
  }

  FutureOr<void> refuseJoinRequest(
      RefuseJoinRequestEvent event, Emitter<FilesState> emit) async {
    emit(RefuseJoinRequestLoadingState());
    var response =
        await filesRepo.refuseJoinRequest(requestID: event.requestID);
    if (response)
      emit(RefuseJoinRequestSuccessState());
    else
      emit(RefuseJoinRequestErrorState());
  }

  FutureOr<void> acceptJoinRequest(
      AcceptJoinRequestEvent event, Emitter<FilesState> emit) async {
    emit(AcceptJoinRequestLoadingState());
    var response =
        await filesRepo.acceptJoinRequest(requestID: event.requestID);
    if (response)
      emit(AcceptJoinRequestSuccessState());
    else
      emit(AcceptJoinRequestErrorState());
  }

  FutureOr<void> getMyCheckedInFiles(
      GetMyCheckedInFilesEvent event, Emitter<FilesState> emit) async {
    emit(GetMyCheckedInFilesLoadingState());
    log('flag');
    myCheckedInFiles = [];
    var response = await filesRepo.getMyCheckedInFiles();
    if (response.success!) {
      myCheckedInFiles = response.data!;
      print(myCheckedInFiles.length);
      checkedOutFileID =  myCheckedInFiles?.isNotEmpty ?? false ? myCheckedInFiles.first.fileId : null;
      print("check in files list size : ${myCheckedInFiles.length}");
      if (myCheckedInFiles.length>0) {
        print('my checked in files : ');
        for (var file in myCheckedInFiles) print(file.fileName);
      }

      emit(GetMyCheckedInFilesSuccessState());
    } else
      emit(GetMyCheckedInFilesErrorState());
  }

  int? checkedOutFileID;
  PlatformFile? checkedOutFile;

  FutureOr<void> chooseFile(event, Emitter<FilesState> emit) {
    checkedOutFile = event.file;
    emit(ChooseFileState());
  }

  FutureOr<void> chooseFileID(
      ChooseFileIDEvent event, Emitter<FilesState> emit) {
    checkedOutFileID = event.id!;
    emit(ChooseFileIDState());
  }

  FutureOr<void> checkOutFile(
      CheckOutFileEvent event, Emitter<FilesState> emit) async {
    emit(CheckOutFileLoadingState());
    var response =
        await filesRepo.checkOutFile(file: event.file, fileID: event.fileID);
    if (response) {
      checkedOutFile = null;
      checkedOutFileID = null;
      emit(CheckOutFileSuccessState());
    } else
      emit(CheckInFilesErrorState());
  }

  FutureOr<void> blockUser(BlockUserEvent event, Emitter<FilesState> emit)async {
    emit(BlockUserLoadingState());
    var response= await filesRepo.blockUser(userID: event.userID, groupID: event.groupID);
    if (response)
      emit(BlockUserSuccessState());
    else emit(BlockUserErrorState());
  }
}
