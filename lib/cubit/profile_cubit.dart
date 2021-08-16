import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:doctoworld_doctor/models/availability.dart';
import 'package:doctoworld_doctor/models/faq_question.dart';
import 'package:doctoworld_doctor/models/hospital.dart';
import 'package:doctoworld_doctor/models/service.dart';
import 'package:doctoworld_doctor/models/specialization.dart';
import 'package:doctoworld_doctor/models/user.dart';
import 'package:doctoworld_doctor/utils/api_routes.dart';
import 'package:doctoworld_doctor/utils/config.dart';
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

  List<Availability> _availabilities = [
    Availability(
      day: 'Saturday',
      from: TimeOfDay(hour: 0, minute: 0),
      to: TimeOfDay(hour: 0, minute: 0),
      isChecked: false,
    ),
    Availability(
      day: 'Sunday',
      from: TimeOfDay(hour: 0, minute: 0),
      to: TimeOfDay(hour: 0, minute: 0),
      isChecked: false,
    ),
    Availability(
      day: 'Monday',
      from: TimeOfDay(hour: 0, minute: 0),
      to: TimeOfDay(hour: 0, minute: 0),
      isChecked: false,
    ),
    Availability(
      day: 'Tuesday',
      from: TimeOfDay(hour: 0, minute: 0),
      to: TimeOfDay(hour: 0, minute: 0),
      isChecked: false,
    ),
    Availability(
      day: 'Wednesday',
      from: TimeOfDay(hour: 0, minute: 0),
      to: TimeOfDay(hour: 0, minute: 0),
      isChecked: false,
    ),
    Availability(
      day: 'Thursday',
      from: TimeOfDay(hour: 0, minute: 0),
      to: TimeOfDay(hour: 0, minute: 0),
      isChecked: false,
    ),
    Availability(
      day: 'Friday',
      from: TimeOfDay(hour: 0, minute: 0),
      to: TimeOfDay(hour: 0, minute: 0),
      isChecked: false,
    ),
  ];

  late Dio dio;

  List<FAQQuestion> faqs = [];
  String termsAndConditionsText = '';

  User? user;

  List<Service> _services = [];
  List<Specialization> _specifications = [];
  List<Hospital> _hospitals = [];

  List<Availability> get availabilities => _availabilities;
  List<Service> get services => _services;
  List<Specialization> get specifications => _specifications;
  List<Hospital> get hospitals => _hospitals;

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
      print(ApiRoutes.UPDATE_PERSONAL_INFO);
      Response response = await dio.put(
        ApiRoutes.UPDATE_PERSONAL_INFO,
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

      if (response.statusCode == 200) {
        emit(PersonalInfoUpdatedState());
      }
    } on DioError catch (e) {
      print(e.response?.data);
      print(e.response?.statusCode);
      if (e.response?.statusCode == 403) {
        await Config.unAuthenticateUser();
      } else if (e.response?.statusCode == 422) {
        String errorMsg = 'Ops, Something went wrong';
        if (e.response?.data['error']['email'] != null) {
          errorMsg = e.response?.data['error']['email'][0];
        } else if (e.response?.data['error']['contact_number'] != null) {
          errorMsg = e.response?.data['error']['contact_number'][0];
        } else if (e.response?.data['error']['name'] != null) {
          errorMsg = e.response?.data['error']['name'][0];
        }
        SharedWidgets.showToast(msg: errorMsg, isError: true);
      }
    }
  }

  Future<void> updateExperienceAndFees({
    required String years,
    required String fees,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(ApiRoutes.UPDATE_FEES_EXPERIENCE);
      Response response = await dio.put(
        ApiRoutes.UPDATE_FEES_EXPERIENCE,
        data: {
          'experience': years,
          'fees': fees,
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
        emit(ExperienceAndFeesUpdatedState());
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

  Future<void> updateServices({
    required List<Service> services,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(ApiRoutes.UPDATE_SERVICES);
      print(services
          .where((serv) => serv.isChecked)
          .map((serv) => serv.id)
          .toList());
      Response response = await dio.put(
        ApiRoutes.UPDATE_SERVICES,
        data: {
          'services': services
              .where((serv) => serv.isChecked)
              .map((serv) => serv.id)
              .toList(),
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
        emit(ServicesUpdatedState());
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

  Future<void> updateSpecializations({
    required List<Specialization> specializations,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(ApiRoutes.UPDATE_SPECIFICATION);
      print(specializations
          .where((spec) => spec.isChecked)
          .map((spec) => spec.id)
          .toList());
      Response response = await dio.put(
        ApiRoutes.UPDATE_SPECIFICATION,
        data: {
          'specifications': specializations
              .where((spec) => spec.isChecked)
              .map((spec) => spec.id)
              .toList(),
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
        emit(SpecializationsUpdatedState());
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

  Future<void> updateAvailabilities() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(ApiRoutes.UPDATE_AVAILABITLITY);
      print(availabilities
          .where((avail) => avail.isChecked)
          .map((avail) => {
                'day': avail.day,
                'from': '${avail.from.hour}:${avail.from.minute}',
                'to': '${avail.to.hour}:${avail.to.minute}',
              })
          .toList());
      Response response = await dio.put(
        ApiRoutes.UPDATE_AVAILABITLITY,
        data: {
          'available_times': availabilities
              .where((avail) => avail.isChecked)
              .map((avail) => {
                    'day': avail.day,
                    'from': '${avail.from.hour}:${avail.from.minute}',
                    'to': '${avail.to.hour}:${avail.to.minute}',
                  })
              .toList(),
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
        emit(AvailabilitiesUpdatedState());
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

  Future<void> updateHospitals({
    required List<Hospital> hospitals,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(ApiRoutes.UPDATE_HOSPITAL);
      print(hospitals
          .where((spec) => spec.isChecked)
          .map((spec) => spec.id)
          .toList());
      Response response = await dio.put(
        ApiRoutes.UPDATE_HOSPITAL,
        data: {
          'hospitals': hospitals
              .where((spec) => spec.isChecked)
              .map((spec) => spec.id)
              .toList(),
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
        emit(SpecializationsUpdatedState());
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

  Future<void> changeProfilePic(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'image': await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
          'app_type': ROLE_NAME,
        },
      );

      await dio.post(
        ApiRoutes.UPDATE_IMAGE,
        data: formData,
      );
    } on DioError catch (e) {
      print(e.response?.statusCode);
      print(e.response?.data);
      if (e.response?.statusCode == 403) {
        await Config.unAuthenticateUser();
      }
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
          List<Availability> checkedAvailabilities = [];
          user = User.fromJson(decodedResponseBody['data']['user']);
          _services = (decodedResponseBody['data']['services'] as List<dynamic>)
              .map((serv) => Service.fromJson(serv))
              .toList();
          _specifications =
              (decodedResponseBody['data']['specifications'] as List<dynamic>)
                  .map((spec) => Specialization.fromJson(spec))
                  .toList();
          checkedAvailabilities =
              (decodedResponseBody['data']['available_times'] as List<dynamic>)
                  .map((json) => Availability.fromJson(json))
                  .toList();
          _hospitals =
              (decodedResponseBody['data']['hospitals'] as List<dynamic>)
                  .map((json) => Hospital.fromJson(json))
                  .toList();

          for (int i = 0; i < _availabilities.length; i++) {
            for (int j = 0; j < checkedAvailabilities.length; j++) {
              if (_availabilities[i] == checkedAvailabilities[j]) {
                _availabilities[i] = checkedAvailabilities[j];
                print(_availabilities[i].toString());
              }
            }
          }

          emit(ProfileLoadedState());
        }
      }

      print(_startTime);
    } on DioError catch (e) {
      print(e.response?.data);
      print(e.error);
      if (e.response?.statusCode == 403) {
        await Config.unAuthenticateUser();
      }
      throw INTERNET_WARNING_MESSAGE;
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
      if (e.response?.statusCode == 403) {
        await Config.unAuthenticateUser();
      }
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
      if (e.response?.statusCode == 403) {
        await Config.unAuthenticateUser();
      }
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
      if (e.response?.statusCode == 403) {
        await Config.unAuthenticateUser();
      }
      throw INTERNET_WARNING_MESSAGE;
    }
  }
}
