import 'dart:io';

import 'package:doctoworld_doctor/exceptions/auth_exception.dart';
import 'package:doctoworld_doctor/utils/api_routes.dart';
import 'package:doctoworld_doctor/utils/config.dart';
import 'package:doctoworld_doctor/utils/constants.dart';
import 'package:doctoworld_doctor/widgets/shared_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  Dio dio = Dio();
  int isVerified = 0; // Documents Approved in Identity Screen
  int hasCredentials = 0; // Doctor Uploaded Documents in Identity Screen
  String? status;
  String? message;

  Future<void> registerWithEmailAndPasswrod({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phone,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(ApiRoutes.REGISTER);
      Response response = await dio.post(ApiRoutes.REGISTER,
          data: {
            "email": email,
            "password": password,
            "name": '$firstName $lastName',
            "contact_number": phone,
            "language": prefs.getString(LOCALE_KEY) ?? DEFAULT_LANGUAGE_CODE,
            "role_name": ROLE_NAME,
          },
          options: Options(headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          }));
      final decodedResponseBody = response.data;
      print(decodedResponseBody);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(decodedResponseBody['access_token']);
        await prefs.setString(TOKEN_KEY, decodedResponseBody['access_token']);
      } else {
        throw AuthException(response.data['error']);
      }
    } on AuthException catch (e) {
      throw e;
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
      String errorMessage = '';
      if (e.response?.statusCode == 422) {
        throw AuthException(e.response?.data['message'][0]);
      }
      if (e.type == DioErrorType.response) {
        (e.response?.data as Map<String, List<String>>).forEach((key, value) {
          errorMessage += '${value[0]}\n';
        });
        throw AuthException(errorMessage);
      }
      throw AuthException(INTERNET_WARNING_MESSAGE);
    }
  }

  Future<void> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(ApiRoutes.LOGIN);
      Response response = await dio.post(
        ApiRoutes.LOGIN,
        data: {
          "email": email,
          "password": password,
          "role_name": ROLE_NAME,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );
      final decodedResponseBody = response.data;
      print(decodedResponseBody);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(decodedResponseBody['access_token']);
        isVerified = decodedResponseBody['is_verified'];
        hasCredentials = decodedResponseBody['has_credentials'];
        status = decodedResponseBody['status'];
        message = decodedResponseBody['message'];
        await prefs.setString(TOKEN_KEY, decodedResponseBody['access_token']);
        await prefs.setInt(VERIFIED_KEY, decodedResponseBody['is_verified']);
        await prefs.setInt(
            CREDENTIALS_KEY, decodedResponseBody['has_credentials']);
        notifyListeners();
      }
    } on DioError catch (e) {
      print(e.error);
      print(e.response?.data);
      if (e.type == DioErrorType.response) {
        if (e.response?.statusCode == 400) {
          throw e.response?.data['message'];
        }
        throw AuthException(e.response?.data['message']);
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> verifyIdentity(
      {required File profileImg,
      required File certificateImg,
      required File nationalIDImg,
      required String qualification}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(ApiRoutes.IDENTITY_VERIFICATION);
      FormData formData = FormData.fromMap(
        {
          'photo': await MultipartFile.fromFile(
            profileImg.path,
            filename: basename(profileImg.path),
          ),
          'certificate': await MultipartFile.fromFile(
            certificateImg.path,
            filename: basename(certificateImg.path),
          ),
          'personal_id': await MultipartFile.fromFile(
            nationalIDImg.path,
            filename: basename(nationalIDImg.path),
          ),
          'qualification': qualification,
        },
      );

      Response response = await dio.post(
        ApiRoutes.IDENTITY_VERIFICATION,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${prefs.getString(TOKEN_KEY)}',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );
      final decodedResponseBody = response.data;
      print(decodedResponseBody);
      print(response.statusCode);
      if (response.statusCode == 200) {
        isVerified = decodedResponseBody['is_verified'];
        hasCredentials = decodedResponseBody['has_credentials'];
        status = decodedResponseBody['status'];
        message = decodedResponseBody['message'];
        await prefs.setInt(VERIFIED_KEY, isVerified);
        await prefs.setInt(CREDENTIALS_KEY, hasCredentials);
        notifyListeners();
      }
    } on DioError catch (e) {
      print(e.error);
      print(e.response?.data);
      if (e.type == DioErrorType.response) {
        if (e.response?.statusCode == 403) {
          await Config.unAuthenticateUser();
        }
      }
      throw Exception(e.message);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> changeLanguage(String langCode) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(ApiRoutes.CHANGE_LANGUAGE);
      Response response = await dio.post(
        ApiRoutes.CHANGE_LANGUAGE,
        data: {
          "language": langCode,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${prefs.getString(TOKEN_KEY)}',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );
      final decodedResponseBody = response.data;
      print(decodedResponseBody);
      print(response.statusCode);
      if (response.statusCode == 200) {
        notifyListeners();
      } else {
        throw INTERNET_WARNING_MESSAGE;
      }
    } on DioError catch (e) {
      print(e.error);
      print(e.response?.statusCode);
      print(e.response?.data);
      if (e.response?.statusCode == 403) {
        await Config.unAuthenticateUser();
      }
      throw INTERNET_WARNING_MESSAGE;
    }
  }

  Future<void> logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(ApiRoutes.LOGOUT);
      Response response = await dio.post(
        ApiRoutes.LOGOUT,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${prefs.getString(TOKEN_KEY)}',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );
      final decodedResponseBody = response.data;
      print(decodedResponseBody);
      print(response.statusCode);
      if (response.statusCode == 200) {
        SharedWidgets.showToast(msg: decodedResponseBody['message']);
        await Config.unAuthenticateUser();
        notifyListeners();
      } else {
        throw INTERNET_WARNING_MESSAGE;
      }
    } on DioError catch (e) {
      print(e.error);
      print(e.response?.statusCode);
      print(e.response?.data);
      if (e.response?.statusCode == 403) {
        await Config.unAuthenticateUser();
      }
      throw INTERNET_WARNING_MESSAGE;
    }
  }
}
