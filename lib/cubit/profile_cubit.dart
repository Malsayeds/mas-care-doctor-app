import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:doctoworld_doctor/models/availability.dart';
import 'package:doctoworld_doctor/models/faq_question.dart';
import 'package:doctoworld_doctor/models/profile.dart';
import 'package:doctoworld_doctor/models/service.dart';
import 'package:doctoworld_doctor/models/specification.dart';
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

  Profile profile = Profile(
    imgUrl: imagePlaceHolderError,
    experience: 0,
    fees: 0,
    mail: '',
    name: '',
    phoneNumber: '',
  );

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

  List<Service> _services = [
    Service(
      id: 0,
      isChecked: true,
      title: 'test 1',
    ),
    Service(
      id: 0,
      isChecked: false,
      title: 'test 2',
    ),
  ];

  List<Specification> _specifications = [
    Specification(
      id: 0,
      title: 'Test 3',
      isChecked: true,
    ),
    Specification(
      id: 1,
      title: 'Test 5',
      isChecked: false,
    ),
  ];

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

      print(_startTime);
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
      Response<Map<String, dynamic>?> response = await dio.get(
        ApiRoutes.FAQ,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${prefs.getString(TOKEN_KEY)}',
          },
        ),
      );
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
        throw Exception();
      }
    } on DioError catch (e) {
      print(e.response?.data);
      print(e.error);
    } catch (e) {
      print(e.toString());
    }
  }
}
