import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:news_app/components/news_carousel.dart';
import 'package:news_app/components/news_header.dart';
import 'package:news_app/logics/news_api_logic.dart';
import 'package:news_app/models/news_response_model.dart';
import 'package:news_app/pages/news_detail_page.dart';
import 'package:news_app/components/news_list_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class NewsHomePage extends StatefulWidget {
  const NewsHomePage({super.key});

  @override
  State<NewsHomePage> createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  NewsApiLogic _newsApiLogic = NewsApiLogic();
  NewsResponseModel? _newsModel;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  // Method to fetch news
  Future<void> _fetchNews() async {
    try {
      var model = await _newsApiLogic.getNews();
      if (model != null && model.articles != null) {
        setState(() {
          _newsModel = model;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      log("Error fetching news: $e");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            NewsHeader(),
            NewsCarousel(newsModel: _newsModel, isLoading: _isLoading),
            Expanded(
              child: NewsListView(
                newsModel: _newsModel,
                isLoading: _isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
