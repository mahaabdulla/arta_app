import 'package:arta_app/core/constants/svg_images.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -30, end: 30).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/onboarding');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.25),
        child: SvgPicture.asset(
          topIntersect,
          fit: BoxFit.cover,
          width: screenWidth,
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_animation.value, 0),
                      child: child,
                    );
                  },
                  child: Image.asset(
                    'assets/png_images/Rectangle 85.png',
                    width: screenWidth * 0.6,
                    height: screenHeight * 0.2,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text('تطبيق عرطة', style: TextStyles.headLine1),
              ],
            ),
          );
        },
      ),
      bottomSheet: SvgPicture.asset(
        'assets/svg_images/Intersect 2-2.svg',
        fit: BoxFit.cover,
        width: screenWidth,
        height: screenHeight * 0.1,
      ),
    );
  }
}
