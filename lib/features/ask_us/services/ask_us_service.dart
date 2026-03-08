import 'package:dio/dio.dart';
import 'package:inheritance/core/api_service/api_consumer.dart';
import 'package:inheritance/core/api_service/end_points.dart';
import 'package:inheritance/core/service_locator/service_locator.dart';

class AskUsService {
  final ApiConsumer api = serviceLocator<ApiConsumer>();

  Future<void> sendQuestion({
    required String name,
    required String mobile,
    required String email,
    required String question,
  }) async {
    try {
      await api.post(
        EndPoint.comments,
        data: {"name": name, "mobile": mobile, "email": email, "question": question},
      );
    } catch (e) {
      if (e is DioException) {
        throw Exception(e.response?.data ?? 'Unknown error');
      }

      throw Exception('Unknown error');
    }
  }
}
