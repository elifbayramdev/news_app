import 'dart:convert';
import 'dart:developer';
import 'package:timeago/timeago.dart' as timeago;
import 'package:news_app/models/news_response_model.dart';
import 'package:http/http.dart' as http;

class NewsApiLogic {
  final String apiKey = 'YOUR_API_KEY_HERE';
  final String baseUrl =
      'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=';

  Future<NewsResponseModel?> getNews() async {
    final response = await http.get(
      Uri.parse('$baseUrl$apiKey'),
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
