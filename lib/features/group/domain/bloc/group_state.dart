import 'package:web_app/features/group/domain/model/group_list_model.dart';

abstract class GroupState {}
class GroupInitialState extends GroupState{}
class AddGroupLoadingState extends GroupState{}
class AddGroupErrorState extends GroupState{}
class AddGroupSuccessState extends GroupState{}
class GetAllGroupsLoadingState extends GroupState{}
class GetAllGroupsErrorState extends GroupState{}
class GetAllGroupsSuccessState extends GroupState{
  final GroupListModel groupListModel;
  GetAllGroupsSuccessState({required this.groupListModel});
}
class GetMyGroupsLoadingState extends GroupState{}
class GetMyGroupsErrorState extends GroupState{}
class GetMyGroupsSuccessState extends GroupState{}

class JoinGroupRequestLoadingState extends GroupState{}
class JoinGroupRequestErrorState extends GroupState{}
class JoinGroupRequestSuccessState extends GroupState{}
