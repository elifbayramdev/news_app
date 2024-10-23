import 'dart:convert';
import 'dart:developer';
import 'package:timeago/timeago.dart' as timeago;
import 'package:news_app/models/news_response_model.dart';
import 'package:http/http.dart' as http;

class NewsApiLogic {
  final String apiKey = '81bf09187afe485ea8204c913e7e8057';
  final String baseUrl =
      'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=';
  final String apiUrl =
      'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=81bf09187afe485ea8204c913e7e8057';

  Future<NewsResponseModel?> getNews() async {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var lastResponse = NewsResponseModel.fromJson(jsonDecode(response.body));
      log(lastResponse.toJson().toString());
      return lastResponse;
    } else {
      return null;
    }
  }

  String formatPublishedAt(String publishedAt) {
    DateTime dateTime = DateTime.parse(publishedAt);
    return timeago.format(dateTime, locale: 'en_short');
  }
}
