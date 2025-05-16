import 'package:arta_app/core/constants/svg_images.dart';
import 'package:arta_app/core/utils/extensions/app_nav_bar.dart';
import 'package:arta_app/feature/presentations/pages/ads/presition/widgets/advertisements.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BasicScaffold extends StatelessWidget {
  final Widget widgets;
  final ScrollController scrollController;
  final bool isScrolled;
  final Widget? header;
  final bool showBackButton;

  const BasicScaffold({
    super.key,
    required this.widgets,
    required this.scrollController,
    required this.isScrolled,
    this.header,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 280,
            pinned: true,
            backgroundColor:  Colors.transparent,
            //isScrolled ? Colors.teal : Colors.transparent,
            elevation: isScrolled ? 2 : 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  SvgPicture.asset(
                    group1,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 300,
                  ),
                  if (header != null)
                    const Positioned.fill(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: AdvertisementsView(),
                        ),
                      ),
                    ),
                  if (showBackButton)
                    Positioned(
                      top: 40,
                      right: 16,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: SvgPicture.asset(
                          iconsArrow,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: widgets,
            ),
          ),
        ],
      ),
    );
  }
}
