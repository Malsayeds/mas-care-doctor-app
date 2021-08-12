import 'package:bloc/bloc.dart';
import 'package:doctoworld_doctor/exceptions/auth_exception.dart';
import 'package:doctoworld_doctor/utils/api_routes.dart';
import 'package:doctoworld_doctor/utils/config.dart';
import 'package:doctoworld_doctor/utils/constants.dart';
import 'package:doctoworld_doctor/widgets/shared_widgets.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  Dio dio = Dio();

  AuthCubit() : super(AuthInitial());

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
            "first_name": firstName,
            "last_name": lastName,
            "phone": phone,
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
        emit(UserRegisteredSuccessfullyState());
      } else {
        throw AuthException(response.data['error']);
      }
    } on AuthException catch (e) {
      throw e;
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
      String errorMessage = '';
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
        await prefs.setString(TOKEN_KEY, decodedResponseBody['access_token']);
        emit(UserLoggedInSuccessfullyState());
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
        await Config.unAuthenticatedUser();
        emit(UserLoggedOutSuccessfullyState());
      } else {
        throw INTERNET_WARNING_MESSAGE;
      }
    } on DioError catch (e) {
      print(e.error);
      print(e.response?.statusCode);
      print(e.response?.data);
      if (e.response?.statusCode == 403) {
        await Config.unAuthenticatedUser();
      }
      throw INTERNET_WARNING_MESSAGE;
    }
  }
}
