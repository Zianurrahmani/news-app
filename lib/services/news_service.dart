import 'package:dio/dio.dart';
import 'package:news_app/presentation/home/models/article_model.dart';

class NewsService {
  static const String _apiKey = "83844eb82f894e548680da004670decb";
  static const String _baseUrl = "https://newsapi.org/v2";

  final Dio _dio = Dio();

  Future<List<ArticleModel>> fetchTopHeadlinesUSA() async {
    try {
      final response = await _dio.get(
        "$_baseUrl/top-headlines",
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
      throw Exception("Unexpected error: $e");
    }
  }

  Future<List<ArticleModel>> searchNews(String keyword) async {
    try {
      final response = await _dio.get(
        "$_baseUrl/everything",
        queryParameters: {
          "q": keyword,
          "apiKey": _apiKey,
        },
      );

      return (response.data["articles"] as List).map((e) => ArticleModel.fromJson(e)).toList();
    } catch (e, s) {
      print(e);
      print(s);
      throw Exception("Failed to search news");
    }
  }

  Future<List<ArticleModel>> getNewsByCategory(String category) async {
    try {
      final response = await _dio.get(
        "$_baseUrl/top-headlines",
        queryParameters: {
          "country": "us",
          "category": category,
          "apiKey": _apiKey,
        },
      );

      final List items = response.data["articles"] ?? [];
      return items.map((e) => ArticleModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Failed to fetch category news");
    }
  }
}
