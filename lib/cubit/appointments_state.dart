part of 'appointments_cubit.dart';

@immutable
abstract class AppointmentsState {}

class AppointmentsInitial extends AppointmentsState {}

class AppointmentsLoadedState extends AppointmentsState {}

class AppointmentStatusChangedState extends AppointmentsState {}
