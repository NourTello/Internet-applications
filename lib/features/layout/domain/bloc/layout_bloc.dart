import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_app/features/auth/presentation/screens/login_screen.dart';
import 'package:web_app/features/files/presentation/screens/check_out_file_screen.dart';
import 'package:web_app/features/files/presentation/screens/files_screen.dart';
import 'package:web_app/features/layout/domain/bloc/layout_states.dart';

import '../../../group/presentation/screens/all_groups_screen.dart';
import '../../../group/presentation/screens/my_groups_screen.dart';
import 'layout_events.dart';

class LayoutBloc extends Bloc<LayoutEvent,LayoutStates>{

  static LayoutBloc get(context)=>BlocProvider.of(context);
  LayoutBloc():super(LayoutInitialState()){
    on<ChangeTabEvent>(changeTab);
  }
   int currentTab=0;
  int currentGroupID=0;
  int? currentFileID;
  List<String> tabsNames=['All groups','My groups','Check out file','Log out'];
  List<IconData>tabsIcons=[Icons.group,Icons.person,Icons.file_open,Icons.logout];
  List<Widget>tabs=[GroupScreen(),MyGroupsScreen(),CheckOutFileScreen(),Center(),FilesScreen()];

  FutureOr<void> changeTab(event, Emitter emit) {
    currentTab=event.newTab;
    print("current tab : $currentTab");
    emit(LayoutChangeTabState());
  }
}