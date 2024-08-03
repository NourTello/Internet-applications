abstract class AuthEvent {}
class AuthInitialEvent extends AuthEvent{}
class LoginShowPasswordEvent extends AuthEvent{}
class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  LoginEvent({required this.email, required this.password});
}
class RegisterShowPasswordEvent extends AuthEvent{}
class RegisterEvent extends AuthEvent{
  final String name;
  final String email;
  final String password;

  RegisterEvent({required this.name,required this.email, required this.password});
}
class LogOutEvent extends AuthEvent {}

