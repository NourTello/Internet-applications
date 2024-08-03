import 'dart:html';

import '../models/group_model.dart';

abstract class FilesState {}
class FilesInitialState extends FilesState{}
class SelectFileState extends FilesState{}
class GetGroupLoadingState extends FilesState{}
class GetGroupSuccessState extends FilesState{
  List<Files>groupFilesList;
  GetGroupSuccessState({required this.groupFilesList});
}
class GetGroupErrorState extends FilesState{
  String errorMessage;
  GetGroupErrorState({required this.errorMessage});
}
class UploadFileSuccessState extends FilesState{}
class UploadFileLoadingState extends FilesState{}
class UploadFileErrorState extends FilesState{
  String errorMessage;
  UploadFileErrorState({required this.errorMessage});

}
class CheckInFilesLoadingState extends FilesState{}
class CheckInFilesSuccessState extends FilesState{}
class CheckInFilesErrorState extends FilesState{}

class GetGroupJoinRequestsLoadingState extends FilesState{}
class GetGroupJoinRequestsErrorState extends FilesState{}
class GetGroupJoinRequestsSuccessState extends FilesState{}

class AcceptJoinRequestLoadingState extends FilesState{}
class AcceptJoinRequestSuccessState extends FilesState{}
class AcceptJoinRequestErrorState extends FilesState{}

class RefuseJoinRequestLoadingState extends FilesState{}
class RefuseJoinRequestSuccessState extends FilesState{}
class RefuseJoinRequestErrorState extends FilesState{}

class GetMyCheckedInFilesLoadingState extends FilesState{}
class GetMyCheckedInFilesSuccessState extends FilesState{}
class GetMyCheckedInFilesErrorState extends FilesState{}

class ChooseFileState extends FilesState{}
class ChooseFileIDState extends FilesState{}

class CheckOutFileLoadingState extends FilesState{}
class CheckOutFileSuccessState extends FilesState{}
class CheckOutFileErrorState extends FilesState{}


class BlockUserLoadingState extends FilesState{}
class BlockUserSuccessState extends FilesState{}
class BlockUserErrorState extends FilesState{}