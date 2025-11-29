import 'package:dio/dio.dart';
import 'package:news_app/presentation/home/models/article_model.dart';

class NewsService {
  static const String _apiKey = "83844eb82f894e548680da004670decb";
  static const String _baseUrl = "https://newsapi.org/v2/top-headlines";

  final Dio _dio = Dio();

  Future<List<ArticleModel>> fetchTopHeadlinesUSA() async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'country': 'us',
          'apiKey': _apiKey,
        },
      );

      // success status check
      if (response.statusCode == 200) {
        final List jsonList = response.data['articles'];
        return jsonList.map<ArticleModel>((e) => ArticleModel.fromJson(e)).toList();
      } else {
        throw Exception("API returned status ${response.statusCode}");
      }
    } on DioException catch (e) {
      // Handle Dio-specific errors
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection timeout");
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception("Receive timeout");
      }
      if (e.type == DioExceptionType.badResponse) {
        throw Exception(
          "Bad response: ${e.response?.statusCode} - ${e.response?.statusMessage}",
        );
      }

      throw Exception("Network error: ${e.message}");
    } catch (e) {
      // Fallback for any other exception
      throw Exception("Unexpected error: $e");
    }
  }
}
