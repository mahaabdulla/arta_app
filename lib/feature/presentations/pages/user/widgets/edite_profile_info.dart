import 'package:arta_app/core/constants/png_images.dart';
import 'package:arta_app/feature/presentations/pages/user/widgets/profile_list_tile_widget.dart';
import 'package:arta_app/feature/presentations/pages/user/widgets/profile_scafoold.dart';
import 'package:flutter/material.dart';

class EditeProfileInfo extends StatelessWidget {
  EditeProfileInfo({super.key});

  final List<Map<String, dynamic>> profileOptions = [
    {
      "title": "تعديل الاسم",
      // "icon": change_profile_info,
      "route": "/home",
    },
    {
      "title": "تعديل كلمة المرور",
      // "icon": change_profile_info,
      "route": "/home",
    },
    {
      "title": "تعديل البريد الالكتروني",
      // "icon": change_profile_info,
      "route": "/home",
    },
    {
      "title": "تعديل رقم الهاتف",
      // "icon": change_profile_info,
      "route": "/home",
    },
    {
      "title": "تعديل رقم الواتساب",
      // "icon": change_profile_info,
      "route": "/home",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ProfileScaffold(
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color(0xffD6D6D6), width: 1),
        ),
        child: ListView.separated(
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
              Divider(color: Color(0xffD6D6D6)),
        ),
      ),
    );
  }
}
