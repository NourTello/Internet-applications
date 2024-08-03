import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_app/core/componant/text_style.dart';
import 'package:web_app/core/const/light-colors.dart';
import 'package:web_app/core/const/string_const.dart';
import 'package:web_app/features/files/presentation/screens/files_screen.dart';
import 'package:web_app/features/group/data/repo/group_repo.dart';
import 'package:web_app/features/group/domain/bloc/group_bloc.dart';
import 'package:web_app/features/group/domain/bloc/group_event.dart';
import 'package:web_app/features/group/domain/bloc/group_state.dart';
import 'package:web_app/features/layout/domain/bloc/layout_bloc.dart';
import 'package:web_app/features/layout/domain/bloc/layout_events.dart';
import '../widgets/group_tile.dart';
import '../widgets/show_dialog_to_add_group.dart';

class MyGroupsScreen extends StatelessWidget {
  MyGroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.sizeOf(context).height;
    double width=MediaQuery.sizeOf(context).width;

    return BlocProvider(
        create: (BuildContext context) => GroupBloc(groupRepo: GroupRepo())..add(GetMyGroupsEvent()),
        child: BlocListener<GroupBloc, GroupState>
          (listener: (context, state) {
          if (state is AddGroupSuccessState) {
            print("done add");
          }
        },
            child: BlocBuilder<GroupBloc, GroupState>(
                builder: (context, state) {
                  GroupBloc bloc=GroupBloc.get(context);
                  LayoutBloc layoutBloc =LayoutBloc.get(context);
                  if (state is GetMyGroupsLoadingState)
                    return Center(child: CircularProgressIndicator());

                  else if (state is GetMyGroupsErrorState)
                    return Scaffold(body:Center(child: Text(StringConst.somethingWrong,style: titleTextStyle(size: 50),),) ,)                     ;

                  else if (state is GetMyGroupsSuccessState)
                    return Scaffold(
                      floatingActionButton: FloatingActionButton(
                        onPressed: () async {
                          await  showAlertDialogToAdd(context);
                        },
                        child: Icon(Icons.add_card,color: Colors.white,weight: 3),
                        backgroundColor:primaryColor,
                      ),
                      body: SingleChildScrollView(
                        child: Column(
                          children: [
                            GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: height / 3.4,
                                  mainAxisSpacing: 20,
                                  crossAxisCount: 6,
                                  crossAxisSpacing: 20,
                                ),
                                shrinkWrap: true,
                                itemBuilder: (context,index) =>
                                    GroupTile(width: width,name:bloc.myGroups[index].groupName!,userIn:true ,id:bloc.myGroups[index].groupId!,
                                        onTab: () {
                                          layoutBloc.currentGroupID=bloc.myGroups[index].groupId!;
                                          layoutBloc.add(ChangeTabEvent(newTab: 4));
                                        }                                        ),
                                itemCount:bloc.myGroups.length),

                          ],
                        ),
                      ),
                    );

                  else
                    return SizedBox();
                }
            )));
  }
}

