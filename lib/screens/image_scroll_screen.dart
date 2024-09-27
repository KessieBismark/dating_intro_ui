import 'package:dating_intro_ui/widgets/image_scroll_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';
import '../widgets/content_section.dart';

class ImageScrollScreen extends StatefulWidget {
  const ImageScrollScreen({
    super.key,
  });

  @override
  _ImageScrollScreenState createState() => _ImageScrollScreenState();
}

class _ImageScrollScreenState extends State<ImageScrollScreen>
    with SingleTickerProviderStateMixin {
  late ScrollController _leftController;
  late ScrollController _rightController;
  late AnimationController _animationController;
  final bool _isDisposed = false;
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      int newPage = _pageController.page!.round();
      if (newPage != _currentPage) {
        setState(() {
          _currentPage = newPage;
        });
      }
    });

    _leftController = ScrollController();
    _rightController = ScrollController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isDisposed) {
        _animationController.addListener(_handleAnimation);
        _animationController.repeat(reverse: true);
      }
    });
  }

  void _handleAnimation() {
    if (_isDisposed) return;
    if (_leftController.hasClients && _rightController.hasClients) {
      final leftMaxScroll = _leftController.position.maxScrollExtent;
      final rightMaxScroll = _rightController.position.maxScrollExtent;

      if (leftMaxScroll > 0 && rightMaxScroll > 0) {
        _leftController.jumpTo(_animationController.value * leftMaxScroll);
        _rightController
            .jumpTo((1 - _animationController.value) * rightMaxScroll);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx > 0) {
            // Swiped right
            if (_currentPage > 0) {
              _currentPage--;
              setState(() {});
            }
          } else if (details.velocity.pixelsPerSecond.dx < 0) {
            // Swiped left
            if (_currentPage < 2) {
              _currentPage++;
              setState(() {});
            }
          }
          _pageController.jumpToPage(_currentPage);
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final height = constraints.maxHeight;
            final width = constraints.maxWidth;
            return Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: width,
                      height: height * 0.65,
                      child: PageView(
                        controller: _pageController,
                        children: [
                          ImageScollScreen(
                              height: height,
                              leftController: _leftController,
                              rightController: _rightController),
                          Image.asset(
                            'assets/images/lady.jpg',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                  child: Text('Error loading image'));
                            },
                          ),
                          Image.asset(
                            'assets/images/man.jpg',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                  child: Text('Error loading image'));
                            },
                          ),
                        ],
                      ),
                    ),

                    // Overlay with animated transition for the current index
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: AnimatedSwitcher(
                        duration: const Duration(
                            milliseconds: 500), 
                        child: _buildAnimatedOverlay(_currentPage),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: SizeTransition(
                              axis: Axis.horizontal,
                              sizeFactor: animation,
                              child: child,
                            ),
                          );
                        },
                      ),
                    ),

                    Positioned(
                        top: 0,
                        bottom: 0,
                        child: Container(
                          width: width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.center,
                                colors: Provider.of<ThemeProvider>(context)
                                        .isDarkTheme
                                    ? [
                                        Colors.black,
                                        Colors.black.withOpacity(0.3),
                                        Colors.black.withOpacity(0.1),
                                        Colors.transparent,
                                      ]
                                    : [
                                        Colors.white,
                                        Colors.white.withOpacity(0.3),
                                        Colors.white.withOpacity(0.1),
                                        Colors.transparent,
                                      ]),
                          ),
                        )),
                    Positioned(
                        top: 0,
                        bottom: 0,
                        child: Container(
                          width: width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.center,
                                colors: Provider.of<ThemeProvider>(context)
                                        .isDarkTheme
                                    ? [
                                        Colors.black.withOpacity(0.5),
                                        Colors.black.withOpacity(0.1),
                                        Colors.transparent,
                                      ]
                                    : [
                                        Colors.white.withOpacity(0.5),
                                        Colors.white.withOpacity(0.1),
                                        Colors.transparent,
                                      ]),
                          ),
                        )),
                    Positioned(
                      top: 35,
                      right: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(46, 33, 67, 83),
                              spreadRadius: 1.5,
                              blurRadius: 2,
                              offset: Offset(0, 3),
                            ),
                          ],
                          color: Colors.transparent,
                        ),
                        child: IconButton(
                          onPressed: () {
                            Provider.of<ThemeProvider>(context, listen: false)
                                .toggleTheme();
                          },
                          icon: Icon(
                            Provider.of<ThemeProvider>(context).isDarkTheme
                                ? Icons.light_mode
                                : Icons.dark_mode,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ContentSection(width: width, height: height, currentPage: _currentPage)
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _leftController.dispose();
    _rightController.dispose();
    _pageController.dispose(); 

    super.dispose();
  }
}


// Build overlay widget based on current index
Widget _buildAnimatedOverlay(int index) {
  return Container(
    key: ValueKey<int>(index), 
    alignment: Alignment.center,
    decoration: const BoxDecoration(
      color: Color.fromARGB(46, 0, 0, 0), 
    ),
  );
}

Widget _buildImageWidget(String assetPath) {
  return Image.asset(
    assetPath,
    fit: BoxFit.cover,
    errorBuilder: (context, error, stackTrace) {
      return const Center(child: Text('Error loading image'));
    },
  );
}
