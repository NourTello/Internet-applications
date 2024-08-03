import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:web_app/core/const/app_const.dart';
import 'package:web_app/core/const/light-colors.dart';
import 'package:web_app/features/auth/domain/bloc/auth_event.dart';
import 'package:web_app/features/auth/domain/bloc/auth_state.dart';
import 'package:web_app/features/auth/domain/model/login_model.dart';
import 'package:web_app/features/auth/domain/model/register_model.dart';

import '../../../../core/sharedPereferences/sharedPerefernces.dart';
import '../../data/repo/auth_repo.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;
  String message = "";

  static AuthBloc get(context) => BlocProvider.of(context);
  AuthBloc({required this.authRepo}) : super(AuthInitialState()) {
    on<LoginEvent>(_login);
    on<LoginShowPasswordEvent>(_loginShowPassword);
    on<RegisterShowPasswordEvent>(_registerShowPassword);
    on<RegisterEvent>(_register);
    on<LogOutEvent>(logOut);
  }

  Future<FutureOr<void>> _login(
      LoginEvent event, Emitter<AuthState> emit) async {
    emit(LoginLoadingState());
    LoginModel response =
        await authRepo.login(email: event.email, password: event.password);
    print(response.msg);
    if (response.success!) {
      emit(LoginSuccessState());
      print("Login Success");
      // AppConst.token = response.data!.accessToken;
      await saveToken(response.data!.accessToken!);
      // message=response.msg!;
    } else
      emit(LoginErrorState());
  }

  FutureOr<void> _loginShowPassword(
      LoginShowPasswordEvent event, Emitter<AuthState> emit) {
    print("You are here to show password");
    emit(LoginShowPasswordState());
  }

  FutureOr<void> _registerShowPassword(
      RegisterShowPasswordEvent event, Emitter<AuthState> emit) {
    print("You are here to show password");
    emit(RegisterShowPasswordState());
  }

  FutureOr<void> _register(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(RegisterLoadingState());
    RegisterModel response = await authRepo.register(
        name: event.name, password: event.password, email: event.email);
    print(response.msg);
    if (response.success!) {
      emit(RegisterSuccessState());
      // AppConst.token = response.data!.accessToken;
      await saveToken(response.data!.accessToken!);
      print(response.data);
      // message=response.msg!;
    } else
      emit(RegisterErrorState());
  }

  FutureOr<void> logOut(LogOutEvent event, Emitter<AuthState> emit) async {
    emit(LoginLoadingState());
    await AppConst.prefs.remove('token');

    var response = await authRepo.logOut();
    if (response)
      emit(LogOutSuccessState());
    else
      emit(LogOutErrorState());
  }
}
