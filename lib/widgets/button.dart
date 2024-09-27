import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

class GetStartedBTN extends StatelessWidget {
  const GetStartedBTN({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return ElevatedButton(
        style: ButtonStyle(
            fixedSize: WidgetStatePropertyAll(Size(width, 50)),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            backgroundColor: WidgetStatePropertyAll(
                Provider.of<ThemeProvider>(context).isDarkTheme
                    ? Colors.white
                    : Colors.black)),
        onPressed: () {},
        child: Text(
          'Get Started',
          style: TextStyle(
              color: Provider.of<ThemeProvider>(context).isDarkTheme
                  ? Colors.black
                  : Colors.white),
        ));
  }
}
