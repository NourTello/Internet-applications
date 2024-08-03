import 'dart:html';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

abstract class FilesEvent {}

class FilesInitialEvent extends FilesEvent {}

class SelectFileEvent extends FilesEvent {
  final int index;
  final int id;
  SelectFileEvent({required this.index, required this.id});
}

class GetGroupEvent extends FilesEvent {
  int id;
  GetGroupEvent({required this.id});
}

class UploadFileEvent extends FilesEvent {
  int id;
  PlatformFile file;
  UploadFileEvent({required this.id, required this.file});
}

class CheckInFilesEvent extends FilesEvent {
  int groupID;
  List<int> files;

  CheckInFilesEvent({required this.groupID, required this.files});
}

class AcceptJoinRequestEvent extends FilesEvent {
  int requestID;
  AcceptJoinRequestEvent({required this.requestID});
}

class RefuseJoinRequestEvent extends FilesEvent {
  int requestID;
  RefuseJoinRequestEvent({required this.requestID});
}

class GetJoinRequestsEvent extends FilesEvent {
  int groupID;
  GetJoinRequestsEvent({required this.groupID});
}

class GetMyCheckedInFilesEvent extends FilesEvent {}

class ChooseFileEvent extends FilesEvent {
  PlatformFile? file;

  ChooseFileEvent({required this.file});
}

class ChooseFileIDEvent extends FilesEvent {
  int? id;

  ChooseFileIDEvent({required this.id});
}

class CheckOutFileEvent extends FilesEvent {
  int fileID;
  PlatformFile file;

  CheckOutFileEvent({required this.fileID, required this.file});
}

class BlockUserEvent extends FilesEvent{
  int userID;
  int groupID;

  BlockUserEvent({required this.userID,required this.groupID});
}
