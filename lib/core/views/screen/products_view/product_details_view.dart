import 'package:arta_app/core/constants/svg_images.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/core/views/widgets/products_widgets/blue_container.dart';
import 'package:arta_app/core/views/widgets/products_widgets/products_card.dart';
import 'package:arta_app/core/views/widgets/products_widgets/send_commint_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// واجهة تفاصيل المننج 
class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: screenHeight * 0.55,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset(
                    group1,
                    fit: BoxFit.cover,
                    width: screenWidth,
                    height: screenHeight * 0.5,
                  ),
                  Positioned(
                    top: screenHeight * 0.03,
                    right: screenWidth * 0.04,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/home');
                      },
                      child: SvgPicture.asset(
                        iconsArrow,
                      ),
                    ),
                  ),
                  Positioned(
                    top: screenHeight * 0.13,
                    left: screenWidth * 0.05,
                    right: screenWidth * 0.05,
                    child: const ProductsCard(),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'تفاصيل الاعلان',
                    style: TextStyles.medium18,
                    maxLines: 5,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  const Text(
                    'نص تجريبي يستخدم في تصميم الواجهات والمشاريع. هذا النص هو مجرد نص وهمي يهدف إلى ملء المساحات، وعادةً ما يُستخدم في الطباعة والتصميم.',
                    style: TextStyles.reguler14,
                    maxLines: 10,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3,
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      final items = [
                        BlueContainerWidget(
                          imagePath: 'assets/svg_images/Smartphone 2.svg',
                          text: '7765432',
                          onTap: () {},
                        ),
                        BlueContainerWidget(
                          text: '7787654',
                          onTap: () {
                            // go to watsapp
                          },
                        ),
                        BlueContainerWidget(
                          imagePath: 'assets/svg_images/Share.svg',
                          text: '9876543',
                          onTap: () {
                            // sheard content
                          },
                        ),
                        BlueContainerWidget(
                          imagePath: 'assets/svg_images/Dislike.svg',
                          text: 'ابلاغ عن الاعلان',
                          onTap: () {},
                        ),
                      ];
                      return items[index];
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  TextField(
                    maxLines: 10,
                    decoration: InputDecoration(
                      hintText: 'اضف تعليق على الاعلان...',
                      hintStyle: TextStyles.reguler14,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  // send commint mottom
                  SendCommintBottom(),
                  SizedBox(height: screenHeight * 0.04),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
