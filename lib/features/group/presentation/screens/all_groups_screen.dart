import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_app/core/componant/text_style.dart';
import 'package:web_app/core/const/light-colors.dart';
import 'package:web_app/core/const/string_const.dart';
import 'package:web_app/features/files/domain/bloc/files_state.dart';
import 'package:web_app/features/files/presentation/screens/files_screen.dart';
import 'package:web_app/features/group/data/repo/group_repo.dart';
import 'package:web_app/features/group/domain/bloc/group_bloc.dart';
import 'package:web_app/features/group/domain/bloc/group_event.dart';
import 'package:web_app/features/group/domain/bloc/group_state.dart';
import 'package:web_app/features/layout/domain/bloc/layout_bloc.dart';
import 'package:web_app/features/layout/domain/bloc/layout_events.dart';
import '../widgets/group_tile.dart';
import '../widgets/show_dialog_to_add_group.dart';

class GroupScreen extends StatelessWidget {
  GroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return BlocProvider(
        create: (BuildContext context) =>
            GroupBloc(groupRepo: GroupRepo())..add(GetAllGroupsEvent()),
        child: BlocListener<GroupBloc, GroupState>(listener: (context, state) {
          if (state is AddGroupSuccessState) print("done add");


        }, child: BlocBuilder<GroupBloc, GroupState>(builder: (context, state) {
          LayoutBloc layoutBloc = LayoutBloc.get(context);

          if (state is GetAllGroupsLoadingState)
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          else if (state is GetAllGroupsErrorState)
            return Scaffold(
              body: Center(
                child: Text(
                  StringConst.somethingWrong,
                  style: titleTextStyle(size: 50),
                ),
              ),
            );
          else if (state is GetAllGroupsSuccessState)
            return Scaffold(
              backgroundColor: backgroundColor,
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  await showAlertDialogToAdd(context);
                  context.read<GroupBloc>().add(GetAllGroupsEvent());
                },
                child: Icon(Icons.add_card, color: Colors.white, weight: 3),
                backgroundColor: primaryColor,
              ),
              body:
                  // margin: EdgeInsets.all(20),
                  SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6,
                          crossAxisSpacing: 20,
                          mainAxisExtent: height / 3.4,
                          mainAxisSpacing: 20,
                        ),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => GroupTile(
                            width: width,
                            name: state.groupListModel.groupList[index]
                                ['group_name'],
                            userIn: state.groupListModel.groupList[index]
                                ['user_in'],
                            id: state.groupListModel.groupList[index]['id'],
                            onTab: (state.groupListModel.groupList[index]
                                    ['user_in'])
                                ? () {
                                    layoutBloc.currentGroupID = state
                                        .groupListModel.groupList[index]['id'];
                                    layoutBloc.add(ChangeTabEvent(newTab: 4));
                                  }
                                : () {}),
                        itemCount: state.groupListModel.groupList.length),
                  ],
                ),
              ),
            );
          else
            return SizedBox();
        })));
  }
}
