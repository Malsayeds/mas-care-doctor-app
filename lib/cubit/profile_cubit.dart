import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:doctoworld_doctor/models/availability.dart';
import 'package:doctoworld_doctor/models/faq_question.dart';
import 'package:doctoworld_doctor/models/service.dart';
import 'package:doctoworld_doctor/models/specification.dart';
import 'package:doctoworld_doctor/models/user.dart';
import 'package:doctoworld_doctor/utils/api_routes.dart';
import 'package:doctoworld_doctor/utils/constants.dart';
import 'package:doctoworld_doctor/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitialState()) {
    dio = Dio();
  }

  late Dio dio;

  List<FAQQuestion> faqs = [];
  String termsAndConditionsText = '';

  User? user;

  List<Availability> _availabilities = [
    Availability(
      isChecked: true,
      day: 'fri',
      from: TimeOfDay(hour: 1, minute: 0),
      to: TimeOfDay(hour: 2, minute: 0),
    ),
    Availability(
      isChecked: true,
      day: 'sat',
      from: TimeOfDay(hour: 1, minute: 0),
      to: TimeOfDay(hour: 2, minute: 0),
    ),
    Availability(
      isChecked: false,
      day: 'sun',
      from: TimeOfDay(hour: 1, minute: 0),
      to: TimeOfDay(hour: 2, minute: 0),
    ),
    Availability(
      isChecked: true,
      day: 'mon',
      from: TimeOfDay(hour: 1, minute: 0),
      to: TimeOfDay(hour: 2, minute: 0),
    ),
    Availability(
      isChecked: true,
      day: 'tue',
      from: TimeOfDay(hour: 1, minute: 0),
      to: TimeOfDay(hour: 2, minute: 0),
    ),
    Availability(
      isChecked: true,
      day: 'wed',
      from: TimeOfDay(hour: 1, minute: 0),
      to: TimeOfDay(hour: 2, minute: 0),
    ),
    Availability(
      isChecked: true,
      day: 'thu',
      from: TimeOfDay(hour: 1, minute: 0),
      to: TimeOfDay(hour: 2, minute: 0),
    ),
  ];

  List<Service> _services = [];
  List<Specification> _specifications = [];

  List<Availability> get availabilities => _availabilities;

  List<Service> get services => _services;

  List<Specification> get specifications => _specifications;

  void setFromDate(int i, TimeOfDay FromTime) {
    availabilities[i].from = FromTime;
    emit(FromTimeChangedState());
  }

  void setToDate(int i, TimeOfDay FromTime) {
    availabilities[i].to = FromTime;
    emit(ToTimeChangedState());
  }

  void setDayCheck(int i, bool isChecked) {
    availabilities[i].isChecked = isChecked;
    emit(DayTimeChangedState());
  }

  Future<void> getProfileData() async {
    try {
      String s = '16:00';
      TimeOfDay _startTime = TimeOfDay(
        hour: int.parse(s.split(":")[0]),
        minute: int.parse(s.split(":")[1]),
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(ApiRoutes.PROFILE);
      print('Bearer ${prefs.getString(TOKEN_KEY)}');
      Response<Map<String, dynamic>?> response = await dio.get(
        ApiRoutes.PROFILE,
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
          user = User.fromJson(decodedResponseBody['data']['user']);
          _services = (decodedResponseBody['data']['services'] as List<dynamic>)
              .map((serv) => Service.fromJson(serv))
              .toList();
          _specifications =
              (decodedResponseBody['data']['specifications'] as List<dynamic>)
                  .map((spec) => Specification.fromJson(spec))
                  .toList();
          emit(ProfileLoadedState());
        }
      } else {
        throw INTERNET_WARNING_MESSAGE;
      }

      print(_startTime);
    } on DioError catch (e) {
      print(e.response?.data);
      print(e.error);
      throw INTERNET_WARNING_MESSAGE;
    } catch (e) {}
  }

  Future<void> updateServices() async {
    try {} on DioError catch (e) {
      SharedWidgets.showToast(msg: e.message);
    }
  }

  Future<void> getFAQs() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(ApiRoutes.FAQ);
      print('Bearer ${prefs.getString(TOKEN_KEY)}');
      Response<Map<String, dynamic>?> response = await dio.get(ApiRoutes.FAQ,
          options: Options(headers: {
            'Authorization': 'Bearer ${prefs.getString(TOKEN_KEY)}',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          }));
      final Map<String, dynamic>? decodedResponseBody = response.data;

      print(decodedResponseBody);
      print(response.statusCode);
      if (response.statusCode == 200) {
        if (decodedResponseBody != null) {
          faqs = (decodedResponseBody['data'] as List<dynamic>)
              .map((e) => FAQQuestion.fromJson(e))
              .toList();
          print(faqs);
          emit(FAQsLoadedSuccessfullyState());
        }
      } else {
        print('sadcscd');
        throw INTERNET_WARNING_MESSAGE;
      }
    } on DioError catch (e) {
      print(e.response?.data);
      print(e.error);
      throw INTERNET_WARNING_MESSAGE;
    } catch (e) {
      print(e.toString());
      throw INTERNET_WARNING_MESSAGE;
    }
  }

  Future<void> getTermsAndConditions() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(ApiRoutes.TERMS_AND_CONDITIONS);
      Response<Map<String, dynamic>?> response =
          await dio.get(ApiRoutes.TERMS_AND_CONDITIONS,
              options: Options(headers: {
                'Authorization': 'Bearer ${prefs.getString(TOKEN_KEY)}',
                'Accept': 'application/json',
                'Content-Type': 'application/json',
              }));
      final Map<String, dynamic>? decodedResponseBody = response.data;

      print(decodedResponseBody);
      print(response.statusCode);
      if (response.statusCode == 200) {
        if (decodedResponseBody != null) {
          termsAndConditionsText = decodedResponseBody['body'];
          print(faqs);
          emit(FAQsLoadedSuccessfullyState());
        }
      } else {
        throw Exception();
      }
    } on DioError catch (e) {
      print(e.response?.data);
      print(e.error);
      throw Exception();
    } catch (e) {
      print(e.toString());
      throw Exception();
    }
  }

  Future<void> sendSupportMessage(
      {required String email, required String message}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(ApiRoutes.CONTACT_SUPPORT);
      Response response = await dio.post(ApiRoutes.CONTACT_SUPPORT,
          data: {
            "email": email,
            "message": message,
          },
          options: Options(headers: {
            'Authorization': 'Bearer ${prefs.getString(TOKEN_KEY)}',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          }));
      final decodedResponseBody = response.data;
      print(decodedResponseBody);
      print(response.statusCode);
      if (response.statusCode == 200) {
        SharedWidgets.showToast(msg: decodedResponseBody['message']);
        emit(SupportMessageSentState());
      } else {
        throw INTERNET_WARNING_MESSAGE;
      }
    } on DioError catch (e) {
      print(e.error);
      throw INTERNET_WARNING_MESSAGE;
    }
  }
}
