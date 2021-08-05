part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class IsRegistered extends AuthState {}

class IsLoggedIn extends AuthState {}
