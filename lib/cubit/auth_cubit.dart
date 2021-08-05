import 'package:bloc/bloc.dart';
import 'package:doctoworld_doctor/utils/constants.dart';
import 'package:doctoworld_doctor/widgets/shared_widgets.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  late Dio dio;
  AuthCubit() : super(AuthInitial()) {
    var options = BaseOptions(
      baseUrl: API_URL,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    dio = Dio(options);
  }

  Future<void> registerWithEmailAndPasswrod(
      {required String email, required String password}) async {
    Response response = await dio.postUri(
      Uri.parse(''),
      options: Options(),
    );
    try {} on DioError catch (e) {
      SharedWidgets.showToast(msg: e.message);
    }
  }

  Future<void> loginWithEmailAndPasswrod(
      {required String email, required String password}) async {
    Response response = await dio.postUri(
      Uri.parse(''),
      options: Options(),
    );
    try {} on DioError catch (e) {
      SharedWidgets.showToast(msg: e.message);
    }
  }
}
