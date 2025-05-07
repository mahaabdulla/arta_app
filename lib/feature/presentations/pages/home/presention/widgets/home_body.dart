import 'package:arta_app/core/constants/svg_images.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/core/utils/extensions/app_nav_bar.dart';
import 'package:arta_app/core/widgets/products_list.dart';
import 'package:arta_app/feature/presentations/pages/ads/presition/widgets/advertisements.dart';
import 'package:arta_app/feature/presentations/pages/home/presention/widgets/categury_list.dart';
import 'package:arta_app/feature/presentations/pages/home/presention/widgets/see_more_buttom.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(280),
        child: Stack(
// =======
//       body: SingleChildScrollView(
//         child: Column(
// >>>>>>> develop
          children: [
            Stack(
              children: [
                SvgPicture.asset(
                  group1,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 300,
                ),
                const Positioned.fill(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: AdvertisementsView(),
                    ),
                  ),
                ),
              ],
            ),
            const Positioned(child: AdvertisementsView()),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                'الفئات',
                style:
                    TextStyles.medium24.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              CategoryList(),
              const SizedBox(height: 16),
                
                //مها ذا حقه وين؟
              // const SearchBarFiltter(),

              ProductsList(),
              const SizedBox(height: 16),
              const SeeMoreButtom(),
            ],
          ),
//             const SizedBox(height: 16),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'الفئات',
//                     style: TextStyles.medium24
//                         .copyWith(fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 16),
//                   CategoryList(),
//                   const SizedBox(height: 16),
//                   const SizedBox(height: 16),
//                   ProductsList(),
//                   const SizedBox(height: 16),
//                   SeeMoreButtom(),
//                 ],
//               ),
//             ),
//           ],
        ),
      ),
    );
  }
}
