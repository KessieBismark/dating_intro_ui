
import 'package:dating_intro_ui/provider/theme_provider.dart';
import 'package:dating_intro_ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'indicator.dart';

class ContentSection extends StatelessWidget {
  const ContentSection({
    super.key,
    required this.width,
    required this.height,
    required int currentPage,
  }) : _currentPage = currentPage;

  final double width;
  final double height;
  final int _currentPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height * 0.35,
      decoration: BoxDecoration(
        color: Provider.of<ThemeProvider>(context).isDarkTheme
            ? Colors.black
            : Colors.white,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          DotIndicator(
            scrollIndex: _currentPage,
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Connect, Share, and Empower",
            style: TextStyle(
                fontWeight: FontWeight.w800, fontSize: 23),
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Join a vibrant community of women supporting women. Share your experinces, discover inspiring stories",
              style: TextStyle(fontSize: 15),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: GetStartedBTN(),
          )
        ],
      ),
    );
  }
}