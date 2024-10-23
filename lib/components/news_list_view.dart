import 'package:flutter/material.dart';
import 'package:news_app/models/news_response_model.dart';
import 'package:news_app/pages/news_detail_page.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:shimmer/shimmer.dart';

class NewsListView extends StatelessWidget {
  final NewsResponseModel? newsModel;
  final bool isLoading;

  const NewsListView({
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 16),
              // Simulate the list items loading state
              Expanded(
                child: ListView.builder(
                  itemCount: 5, // Simulating 5 loading items
                  itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (newsModel == null ||
        newsModel!.articles == null ||
        newsModel!.articles!.isEmpty) {
      return Center(child: Text("No news available."));
    } else {
      return ListView.builder(
        itemCount: newsModel!.articles!.length,
        itemBuilder: (context, index) {
          var article = newsModel!.articles![index];
          return GestureDetector(
            child: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.transparent,
                border: const GradientBoxBorder(
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 121, 177, 223),
                    Color.fromARGB(255, 216, 146, 225),
                  ]),
                  width: 4,
                ),
              ),
              height: 200,
              width: 200,
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(article.urlToImage ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 30, bottom: 10, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article.title ?? "",
                            overflow: TextOverflow.visible,
                            maxLines: 3,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.edit_rounded, size: 18),
                              Text(
                                article.author ?? "",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                                style: TextStyle(
                                    fontSize: 12,
                                    decoration: TextDecoration.underline),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: Text('Published')),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailPage(
                    title: article.title ?? 'No Title',
                    content: article.content ?? 'No Content',
                    imageUrl:
                        article.urlToImage ?? 'https://via.placeholder.com/150',
                  ),
                ),
              );
            },
          );
        },
      );
    }
  }
}
