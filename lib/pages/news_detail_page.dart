import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/pages/news_home_page.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class NewsDetailPage extends StatefulWidget {
  final String title;
  final String content;
  final String imageUrl;

  const NewsDetailPage({
    Key? key,
    required this.title,
    required this.content,
    required this.imageUrl,
  }) : super(key: key);

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewsHomePage(),
                          ),
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    child: GradientText(
                      'NEWS APP',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                      gradientType: GradientType.linear,
                      colors: [
                        Colors.purple,
                        Colors.blueAccent,
                      ],
                    ),
                    onTap: () {
                      // When clicking turn back to home page
                      print('Hello News App Text');
                    },
                  ),
                  Icon(
                    Icons.account_circle,
                    size: 30,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(widget.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(widget.content),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
