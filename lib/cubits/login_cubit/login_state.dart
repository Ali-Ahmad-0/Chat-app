part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginFailure extends LoginState {
  final String errorMesage;

  LoginFailure({required this.errorMesage});
}

final class LoginLoading extends LoginState {}
