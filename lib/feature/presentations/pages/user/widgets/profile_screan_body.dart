import 'package:arta_app/core/constants/png_images.dart';
import 'package:arta_app/core/constants/svg_images.dart';
import 'package:arta_app/feature/presentations/pages/user/widgets/profile_list_tile_widget.dart';
import 'package:arta_app/feature/presentations/pages/user/widgets/profile_scafoold.dart';
import 'package:flutter/material.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> profileOptions = [
      {
        "title": "تعديل المعلومات الشخصية",
        "icon": profileImage,
        "route": "/home",
      },
      {
        "title": "اللغة",
        "icon": languageImage,
        "route": "/home",
      },
      {
        "title": "المساعدة والدعم",
        "icon": helpsSpport,
        "route": "/home",
      },
      {
        "title": "الأحكام والشروط",
        "icon": condditions,
        "route": "/home",
      },
      {
        "title": "تسجيل الخروج",
        "icon": lougot,
        "route": "/home",
        "showArrow": false,
      },
    ];

    return ProfileScaffold(
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xffD6D6D6), width: 1),
        ),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: profileOptions.length,
          itemBuilder: (context, index) {
            return ProfileListTileWidget(
              title: profileOptions[index]["title"],
              imagePath: profileOptions[index]["icon"],
              color: profileOptions[index]["color"] ?? Colors.black,
              showArrow: profileOptions[index]["showArrow"] ?? true,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  profileOptions[index]["route"],
                );
              },
            );
          },
          separatorBuilder: (context, index) =>
              const Divider(color: Color(0xffD6D6D6)),
        ),
      ),
    );
  }
}
