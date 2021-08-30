import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:doctoworld_doctor/models/appointment.dart';
import 'package:doctoworld_doctor/models/patient.dart';
import 'package:doctoworld_doctor/screens/Auth/Login/UI/login_screen.dart';
import 'package:doctoworld_doctor/utils/api_routes.dart';
import 'package:doctoworld_doctor/utils/config.dart';
import 'package:doctoworld_doctor/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Appointments extends ChangeNotifier {
  Dio dio = Dio();

  List<Appointment> todayAppointments = [];
  List<Appointment> tomorrowAppointments = [];

  Patient? patient;
  Appointment? appointment;

  Future<void> editAppointmentStatus(
      {required int apptId, required int status}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(ApiRoutes.UPDATE_APPT_STATUS);
      Response response = await dio.put(
        ApiRoutes.UPDATE_APPT_STATUS,
        data: {
          'appointment_id': apptId,
          'status': status,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${prefs.getString(TOKEN_KEY)}',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );
      final Map<String, dynamic>? decodedResponseBody = response.data;

      print(decodedResponseBody);
      print(response.statusCode);

      if (response.statusCode == 200) {
        notifyListeners();
      }
    } on DioError catch (e) {
      print(e.response?.statusCode);
      print(e.response?.data);
      if (e.response?.statusCode == 403) {
        await Config.unAuthenticateUser();
      }
      throw INTERNET_WARNING_MESSAGE;
    }
  }

  Future<void> getAppointments() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(ApiRoutes.APPOINTMENTS);
      print('Bearer ${prefs.getString(TOKEN_KEY)}');
      Response<Map<String, dynamic>?> response = await dio.get(
        ApiRoutes.APPOINTMENTS,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${prefs.getString(TOKEN_KEY)}',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );
      final Map<String, dynamic>? decodedResponseBody = response.data;

      print(decodedResponseBody);
      print(response.statusCode);
      if (response.statusCode == 200) {
        if (decodedResponseBody != null) {
          todayAppointments =
              (decodedResponseBody['data']['today'] as List<dynamic>)
                  .map((json) => Appointment.fromJson(json))
                  .toList();
          tomorrowAppointments =
              (decodedResponseBody['data']['tomorrow'] as List<dynamic>)
                  .map((json) => Appointment.fromJson(json))
                  .toList();
          notifyListeners();
        }
      }
    } on DioError catch (e) {
      print(e.response?.data);
      print(e.error);
      if (e.response?.statusCode == 403) {
        await Config.unAuthenticateUser();
      }
      throw INTERNET_WARNING_MESSAGE;
    } catch (e) {
      print(e.toString());
      throw INTERNET_WARNING_MESSAGE;
    }
  }

  Future<void> getAppointmentDetails(int apptId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print('${ApiRoutes.APPOINTMENT_DETAILS}/$apptId');
      print('Bearer ${prefs.getString(TOKEN_KEY)}');
      Response<Map<String, dynamic>?> response = await dio.get(
        '${ApiRoutes.APPOINTMENT_DETAILS}/$apptId',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${prefs.getString(TOKEN_KEY)}',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );
      final Map<String, dynamic>? decodedResponseBody = response.data;

      print(decodedResponseBody);
      print(response.statusCode);
      if (response.statusCode == 200) {
        if (decodedResponseBody != null) {
          appointment = Appointment.fromJson(decodedResponseBody['appointment']);
          patient = Patient.fromMap(decodedResponseBody['patient']);
          notifyListeners();
        }
      }
    } on DioError catch (e) {
      print(e.response?.data);
      print(e.error);
      if (e.response?.statusCode == 403) {
        await Config.unAuthenticateUser();
      }
      throw INTERNET_WARNING_MESSAGE;
    } catch (e) {
      print(e.toString());
      throw INTERNET_WARNING_MESSAGE;
    }
  }
}
