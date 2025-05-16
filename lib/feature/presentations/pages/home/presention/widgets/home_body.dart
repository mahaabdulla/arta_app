import 'package:arta_app/core/constants/svg_images.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/core/utils/extensions/app_nav_bar.dart';
import 'package:arta_app/core/widgets/products_list.dart';
import 'package:arta_app/feature/presentations/pages/ads/presition/widgets/advertisements.dart';
import 'package:arta_app/feature/presentations/pages/home/presention/widgets/categury_list.dart';
import 'package:arta_app/feature/presentations/pages/home/presention/widgets/see_more_buttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset > 50 && !_isScrolled) {
      setState(() => _isScrolled = true);
    } else if (_scrollController.offset <= 50 && _isScrolled) {
      setState(() => _isScrolled = false);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollScafold(
      header: AdvertisementsView(),
      scrollController: _scrollController,
      isScrolled: _isScrolled,
      widgets: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'الفئات',
            style: TextStyles.medium24.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          CategoryList(),
          const SizedBox(height: 16),
          ProductsList(),
          const SizedBox(height: 16),
          const SeeMoreButtom(),
        ],
      ),
    );
  }
}

class CustomScrollScafold extends StatelessWidget {
  final Widget widgets;
  final ScrollController scrollController;
  final bool isScrolled;
  final Widget? header;
  final bool showBackButton;

  const CustomScrollScafold({
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
            backgroundColor: Colors.transparent,
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
