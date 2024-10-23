import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class NewsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 30,
            height: 30,
            child: SvgPicture.asset(
              'assets/vectors/grid_menu.svg',
              width: 30,
              height: 30,
            ),
          ),
          GradientText(
            'NEWS APP',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            gradientType: GradientType.linear,
            colors: [
              Colors.purple,
              Colors.blueAccent,
            ],
          ),
          Icon(
            Icons.account_circle,
            size: 30,
          ),
        ],
      ),
    );
  }
}
