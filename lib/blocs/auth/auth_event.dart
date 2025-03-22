abstract class AuthEvent {}

class LoginRequsted extends AuthEvent {
  final String email;
  final String password;

  LoginRequsted({required this.email, required this.password});
}

class RegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;

  RegisterRequested(
      {required this.name, required this.email, required this.password});
}

class LogoutRequested extends AuthEvent {}

class CheckLoginStatus extends AuthEvent {}
