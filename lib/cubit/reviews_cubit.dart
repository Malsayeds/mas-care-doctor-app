import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:doctoworld_doctor/models/rate.dart';
import 'package:doctoworld_doctor/models/review.dart';
import 'package:doctoworld_doctor/models/user.dart';
import 'package:doctoworld_doctor/utils/api_routes.dart';
import 'package:doctoworld_doctor/utils/config.dart';
import 'package:doctoworld_doctor/utils/constants.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsCubit() : super(ReviewsInitial());
  Dio dio = Dio();

  double avgReviews = 0.0;
  int appointmentsCount = 0;
  User? user;
  List<Review> reviews = [];
  List<Rate> rates = [];

  Future<void> getReviews() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(ApiRoutes.reviews);
      print('Bearer ${prefs.getString(TOKEN_KEY)}');
      Response<Map<String, dynamic>?> response = await dio.get(
        ApiRoutes.reviews,
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
          avgReviews = decodedResponseBody['data']['avg_reviews'];
          appointmentsCount = decodedResponseBody['data']['appointments_count'];
          user = User.fromJson(decodedResponseBody['data']['user']);
          reviews = (decodedResponseBody['data']['reviews'] as List<dynamic>)
              .map((map) => Review.fromJson(map))
              .toList();
          rates = (decodedResponseBody['data']['rates'] as List<dynamic>)
              .map((map) => Rate.fromJson(map))
              .toList();
          emit(ReviewsLoadedState());
        }
      }
    } on DioError catch (e) {
      print(e.response?.data);
      print(e.error);
      if (e.response?.statusCode == 403) {
        await Config.unAuthenticatedUser();
      }
      throw INTERNET_WARNING_MESSAGE;
    } catch (e) {
      print(e.toString());
      throw INTERNET_WARNING_MESSAGE;
    }
  }
}
