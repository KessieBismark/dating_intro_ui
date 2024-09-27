import 'package:dating_intro_ui/utils/image_list.dart';
import 'package:dating_intro_ui/widgets/image_panel.dart';
import 'package:flutter/material.dart';

class ImageScollScreen extends StatelessWidget {
  const ImageScollScreen({
    super.key,
    required this.height,
    required ScrollController leftController,
    required ScrollController rightController,
  })  : _leftController = leftController,
        _rightController = rightController;

  final double height;
  final ScrollController _leftController;
  final ScrollController _rightController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ListView.builder(
              controller: _leftController,
              itemCount: leftImages.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) =>
                  ImagePanel(imagePath: leftImages[index]),
            ),
          ),
        ),
        Expanded(
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ListView.builder(
              controller: _rightController,
              itemCount: rightImages.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) =>
                  ImagePanel(imagePath: rightImages[index]),
            ),
          ),
        ),
      ],
    );
  }
}
