import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/news_response_model.dart';
import 'package:news_app/pages/news_detail_page.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:shimmer/shimmer.dart';

class NewsCarousel extends StatelessWidget {
  final NewsResponseModel? newsModel;
  final bool isLoading;

  const NewsCarousel({
    Key? key,
    required this.newsModel,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(),
      );
    } else if (newsModel == null ||
        newsModel!.articles == null ||
        newsModel!.articles!.isEmpty) {
      return Center(child: Text("No news available."));
    } else {
      return Padding(
        padding: EdgeInsets.all(16),
        child: CarouselSlider(
          options: CarouselOptions(height: 200.0),
          items: newsModel!.articles!
              .take(3) // Only take the first 3 articles
              .map((article) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(16), // Circular border
                          color: Colors.transparent,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              16), // Ensure circular clipping
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(16), // Circular border
                            ),
                            child: Stack(
                              children: [
                                // The Image
                                Image.network(
                                  article.urlToImage ?? '',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                                // Overlay with opacity
                                Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  color: Colors.black.withOpacity(
                                      0.6), // Apply the opacity here
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            article.title ?? 'No Title',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailPage(
                          title: article.title ?? 'No Title',
                          content: article.content ?? 'No Content',
                          imageUrl: article.urlToImage ??
                              'https://via.placeholder.com/150',
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }).toList(),
        ),
      );
    }
  }
}
