import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:doctoworld_doctor/models/availability.dart';
import 'package:doctoworld_doctor/models/faq_question.dart';
import 'package:doctoworld_doctor/models/service.dart';
import 'package:doctoworld_doctor/models/specialization.dart';
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

  final List<String> daysOfWeek = const [
    'Sat',
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
  ];

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
  List<Specialization> _specifications = [];

  List<Availability> get availabilities => _availabilities;

  List<Service> get services => _services;

  List<Specialization> get specifications => _specifications;

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

  Future<void> updatePersonalInfo({
    required String name,
    required String phone,
    required String email,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Response response = await dio.put(
        '',
        data: {
          'name': name,
          'contact_number': phone,
          'email': email,
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

      print(decodedResponseBody);
      print(response.statusCode);
      if (response.statusCode == 200) {
        emit(PersonalInfoUpdatedState());
      }
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> updateExperienceAndFees({
    required String years,
    required String fees,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Response response = await dio.put(
        '',
        data: {
          '': years,
          '': fees,
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

      print(decodedResponseBody);
      print(response.statusCode);
      if (response.statusCode == 200) {
        emit(ExperienceAndFeesUpdatedState());
      }
    } on DioError catch (e) {
      print(e.response?.statusCode);
      print(e.response?.data);
      throw INTERNET_WARNING_MESSAGE;
    }
  }

  Future<void> updateServices({
    required List<Service> services,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Response response = await dio.put(
        '',
        data: {
          '': services,
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

      print(decodedResponseBody);
      print(response.statusCode);
      if (response.statusCode == 200) {
        emit(ServicesUpdatedState());
      }
    } on DioError catch (e) {
      print(e.response?.statusCode);
      print(e.response?.data);
      throw INTERNET_WARNING_MESSAGE;
    }
  }

  Future<void> updateSpecializations({
    required List<Specialization> specializations,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Response response = await dio.put(
        '',
        data: {
          '': specializations,
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

      print(decodedResponseBody);
      print(response.statusCode);
      if (response.statusCode == 200) {
        emit(SpecializationsUpdatedState());
      }
    } on DioError catch (e) {
      print(e.response?.statusCode);
      print(e.response?.data);
      throw INTERNET_WARNING_MESSAGE;
    }
  }

  Future<void> changeProfilePic(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      });

      await dio.post(
        '',
        data: formData,
      );
    } on DioError catch (e) {
      print(e.response?.statusCode);
      print(e.response?.data);
      throw INTERNET_WARNING_MESSAGE;
    }
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
                  .map((spec) => Specialization.fromJson(spec))
                  .toList();
          _availabilities =
              (decodedResponseBody['data']['available_times'] as List<dynamic>)
                  .map((json) => Availability.fromJson(json))
                  .toList();
          List<String> unCheckedDays = getDisabledAvailabilities(
              decodedResponseBody['data']['available_times']);
          unCheckedDays.forEach((day) {
            _availabilities.add(Availability(
                day: day,
                from: TimeOfDay(hour: 0, minute: 0),
                to: TimeOfDay(hour: 0, minute: 0),
                isChecked: false));
          });
          emit(ProfileLoadedState());
        }
      }

      print(_startTime);
    } on DioError catch (e) {
      print(e.response?.data);
      print(e.error);
      throw INTERNET_WARNING_MESSAGE;
    }
  }

  List<String> getDisabledAvailabilities(List<dynamic> responseAvail) {
    List<String> unCheckedDays = daysOfWeek;
    for (Map<String, String> res in responseAvail) {
      if (res['day'] != null && daysOfWeek.contains(res['day'])) {
        unCheckedDays.remove(res['day']);
      }
    }
    return unCheckedDays;
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
