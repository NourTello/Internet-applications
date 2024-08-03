import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_app/features/auth/domain/bloc/auth_event.dart';
import 'package:web_app/features/auth/domain/bloc/auth_state.dart';
import 'package:web_app/features/group/data/repo/group_repo.dart';
import 'package:web_app/features/group/domain/bloc/group_event.dart';
import 'package:web_app/features/group/domain/bloc/group_state.dart';
import 'package:web_app/features/group/domain/model/group_list_model.dart';

import '../model/my_groups_model.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final GroupRepo groupRepo;
  List<GroupData> myGroups = [];

  static GroupBloc get(context)=>BlocProvider.of(context);

  GroupBloc({required this.groupRepo}) : super(GroupInitialState()) {
    on<AddGroupEvent>(_addGroup);
    on<GetAllGroupsEvent>(_getAllGroups);
    on<JoinGroupRequestEvent>(_joinRequest);
    on<GetMyGroupsEvent>(_getMyGroups);
  }

  Future<FutureOr<void>> _addGroup(
      AddGroupEvent event, Emitter<GroupState> emit) async {
    emit(AddGroupLoadingState());
    var response = await groupRepo.addGroup(groupName: event.groupName);
    if (response) {
      emit(AddGroupSuccessState());
      print("add group Success");
    } else
      emit(AddGroupErrorState());
  }

  FutureOr<void> _getAllGroups(
      GetAllGroupsEvent event, Emitter<GroupState> emit) async {
    emit(GetAllGroupsLoadingState());
    var response = await groupRepo.getAllGroups();
    if (response.success) {
      emit(GetAllGroupsSuccessState(groupListModel: response));
      print("show all group Success");
    } else
      emit(GetAllGroupsErrorState());
  }

  FutureOr<void> _joinRequest(
      JoinGroupRequestEvent event, Emitter<GroupState> emit) async {
    emit(JoinGroupRequestLoadingState());
    var response = await groupRepo.joinGroup(groupId: event.groupNum);
    if (response) {
      emit(JoinGroupRequestSuccessState());
      print("join group requesr Success");
    } else
      emit(JoinGroupRequestErrorState());
  }

  FutureOr<void> _getMyGroups(
      GetMyGroupsEvent event, Emitter<GroupState> emit) async {
    emit(GetMyGroupsLoadingState());
    MyGroupsModel response = await groupRepo.getMyGroups();
    if (response.success!) {
      print(response.msg);
      myGroups = response.data!;
      emit(GetMyGroupsSuccessState());
    } else
      emit(GetMyGroupsErrorState());
  }
}
