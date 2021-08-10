part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class FromTimeChangedState extends ProfileState {}

class ToTimeChangedState extends ProfileState {}

class DayTimeChangedState extends ProfileState {}

class FAQsLoadedSuccessfullyState extends ProfileState {}
