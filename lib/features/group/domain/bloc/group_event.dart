abstract class GroupEvent {}
class GroupInitialEvent extends GroupEvent{}
class GetAllGroupsEvent extends GroupEvent{
}
class GetMyGroupsEvent extends GroupEvent{}
class AddGroupEvent extends GroupEvent{
  String groupName;
  AddGroupEvent(this.groupName);
}
class JoinGroupRequestEvent extends GroupEvent{
  int groupNum;
  JoinGroupRequestEvent(this.groupNum);
}
