import 'package:dating_intro_ui/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DotIndicator extends StatefulWidget {
  final int scrollIndex;
  const DotIndicator({super.key, required this.scrollIndex});

  @override
  _DotIndicatorState createState() => _DotIndicatorState();
}

class _DotIndicatorState extends State<DotIndicator>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    currentIndex = widget.scrollIndex;
  }

  @override
  void didUpdateWidget(DotIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.scrollIndex != widget.scrollIndex) {
      setState(() {
        currentIndex = widget.scrollIndex;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            width: currentIndex == index ? 40.0 : 12.0,
            height: 12.0,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(6.0),
              color: currentIndex == index
                  ? const Color.fromARGB(255, 226, 173, 93)
                  : Provider.of<ThemeProvider>(context).isDarkTheme
                      ? const Color.fromARGB(255, 40, 40, 40)
                      : const Color.fromARGB(255, 234, 232, 232),
            ),
          );
        },
      ),
    );
  }
}
