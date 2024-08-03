import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_app/core/componant/text_style.dart';
import 'package:web_app/core/const/light-colors.dart';
import 'package:web_app/features/auth/data/repo/auth_repo.dart';
import 'package:web_app/features/auth/domain/bloc/auth_bloc.dart';
import 'package:web_app/features/auth/domain/bloc/auth_event.dart';
import 'package:web_app/features/auth/presentation/screens/login_screen.dart';
import 'package:web_app/features/group/presentation/screens/all_groups_screen.dart';
import 'package:web_app/features/layout/domain/bloc/layout_events.dart';

import '../../../group/presentation/screens/my_groups_screen.dart';
import '../../domain/bloc/layout_bloc.dart';
import '../../domain/bloc/layout_states.dart';

class HomeLayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => LayoutBloc(),
        child: BlocListener<LayoutBloc, LayoutStates>(
            listener: (BuildContext context, LayoutStates state) {},
            child: BlocBuilder<LayoutBloc, LayoutStates>(
              builder: (BuildContext context, LayoutStates state) {
                double width = MediaQuery.of(context).size.width;
                double height = MediaQuery.of(context).size.height;
                var layoutBloc = LayoutBloc.get(context);
                return SafeArea(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        // width:width/6,
                        width: width / 15,
                        height: height / 1.2,
                        child: ListView.separated(
                            itemBuilder: (context, index) => GestureDetector(
                                  onTap: () {
                                    (index < 3)
                                        ? layoutBloc
                                            .add(ChangeTabEvent(newTab: index))
                                        : {
                                      layoutBloc.currentTab = 0,
                                            AuthBloc(authRepo: AuthRepo())
                                                .add(LogOutEvent()),
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginScreen()))
                                          };
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(layoutBloc.tabsIcons[index],
                                          color: (layoutBloc.currentTab == index)
                                              ? primaryColor
                                              : lightGrey,
                                          size: width / 24),
                                      Text(layoutBloc.tabsNames[index],
                                          textAlign: TextAlign.center,
                                          style: normalTextStyle(
                                            textColor:
                                                (layoutBloc.currentTab == index)
                                                    ? primaryColor
                                                    : lightGrey,
                                          )),
                                    ],
                                  ),
                                ),
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 20),
                            itemCount: layoutBloc.tabsNames.length),
                      ),
                      // VerticalDivider(
                      //   thickness: 1,
                      //   color: Colors.black12,
                      // ),
                      Expanded(child: layoutBloc.tabs[layoutBloc.currentTab])
                    ],
                  ),
                );
              },
            )));
  }
}
