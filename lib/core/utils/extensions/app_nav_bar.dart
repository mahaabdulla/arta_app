import 'package:arta_app/core/constants/colors.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/core/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
  });

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, LOGIN);
        break;
      case 2:
        Navigator.pushNamed(context, MYADS);
        break;
      case 3:
        Navigator.pushNamed(context, CHANGPASS);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      height: 70,
      width: 390.w,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 233, 237, 236),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(context, Icons.home, "الرئيسية", 0),
              _buildNavItem(context, Icons.chat, "محادثة", 1),
              const SizedBox(width: 60),
              _buildNavItem(context, Icons.list_alt, "اعلاناتي", 2),
              _buildNavItem(context, Icons.person, "حسابي", 3),
            ],
          ),
          Positioned(
            top: -30,
            left: MediaQuery.of(context).size.width / 2 - 50,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xff33869C),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.add, size: 32, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, '/addAdvertisement');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
      BuildContext context, IconData icon, String label, int index) {
    final bool isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(context, index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isSelected ? const Color(0xff33869C) : greyText),
          Text(
            label,
            style: TextStyles.reguler14.copyWith(
              color: isSelected ? const Color(0xff33869C) : greyText,
            ),
          ),
        ],
      ),
    );
  }
}
