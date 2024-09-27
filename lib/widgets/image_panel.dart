import 'package:flutter/material.dart';

class ImagePanel extends StatelessWidget {
  final String imagePath;
  const ImagePanel({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        height: 300,
        width: 300,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Center(child: Text('Error loading image'));
            },
          ),
        ),
      ),
    );
  }
}
