import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/feature/presentations/pages/on_boreding/presintion/widgets/introdoction1.dart';
import 'package:arta_app/feature/presentations/pages/on_boreding/presintion/widgets/introdoction2.dart';
import 'package:arta_app/feature/presentations/pages/on_boreding/presintion/widgets/introdoction3.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBordingView extends StatefulWidget {
  const OnBordingView({super.key});

  @override
  State<OnBordingView> createState() => _OnBordingViewState();
}

class _OnBordingViewState extends State<OnBordingView> {
  final PageController _controller = PageController();
  bool onLastPage = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: const [
              Introdoction1(),
              Introdoction2View(),
              Introdoction3View(),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/home');
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text('انتهاء',
                              style: TextStyles.smallReguler
                                  .copyWith(fontWeight: FontWeight.bold)),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: Text(
                          'التالي',
                          style: TextStyles.smallReguler
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                ),
                GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(2);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'تخطي',
                      style: TextStyles.smallReguler
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
