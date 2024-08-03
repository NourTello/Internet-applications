import 'dart:developer';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_app/core/const/light-colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_app/features/auth/presentation/screens/login_screen.dart';
import 'package:web_app/features/files/presentation/screens/check_out_file_screen.dart';
import 'package:web_app/features/group/data/repo/group_repo.dart';
import 'package:web_app/features/group/domain/bloc/group_bloc.dart';
import 'package:web_app/features/layout/presentation/screens/layout_screen.dart';
import 'bloc_observer.dart';
import 'core/const/app_const.dart';
import 'features/auth/data/repo/auth_repo.dart';
import 'features/auth/domain/bloc/auth_bloc.dart';
import 'features/files/presentation/screens/files_screen.dart';
import 'features/group/presentation/screens/all_groups_screen.dart';
import 'features/group/presentation/screens/my_groups_screen.dart';

Future main() async {
  Bloc.observer = const AppBlocObserver();
  AppConst.prefs = await SharedPreferences.getInstance();
  AppConst.token = AppConst.prefs.getString('token');
  print("token : ${AppConst.token}");
  runApp(MyApp(
      mainScreen: AppConst.token == null ? LoginScreen() : HomeLayoutScreen()));
}

class MyApp extends StatelessWidget {
  var mainScreen;

  MyApp({super.key, required this.mainScreen});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) =>
              AuthBloc(authRepo: AuthRepo()),
        ),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'web app',
        themeMode: ThemeMode.light,
        home: mainScreen,
        // home:  FilesScreen(groupID: 2,),
        theme: ThemeData(
          scaffoldBackgroundColor: backgroundColor,
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          primaryColor: primaryColor,
          useMaterial3: true,
        ),
      ),
    );

    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(
    //     scaffoldBackgroundColor: backgroundColor,
    //     colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
    //     primaryColor: primaryColor,
    //     useMaterial3: true,
    //   ),
    //   home: GroupScreen(),
    // );
  }
}
