part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class UserRegisteredSuccessfullyState extends AuthState {}

class UserLoggedInSuccessfullyState extends AuthState {}

class UserLoggedOutSuccessfullyState extends AuthState {}

class UserChangedLanguageState extends AuthState {}
