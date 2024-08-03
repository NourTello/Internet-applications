abstract class AuthState {}
class AuthInitialState extends AuthState{}
class LoginShowPasswordState extends AuthState {}
class LoginLoadingState extends AuthState{}
class LoginSuccessState extends AuthState{
  // final LoginMo
}
class LoginErrorState extends AuthState{}
class RegisterShowPasswordState extends AuthState {}
class RegisterLoadingState extends AuthState{}
class RegisterSuccessState extends AuthState{
  // final LoginMo
}
class RegisterErrorState extends AuthState{}
class LogOutSuccessState extends AuthState{}
class LogOutErrorState extends AuthState{}
class LogOutLoadingState extends AuthState{}