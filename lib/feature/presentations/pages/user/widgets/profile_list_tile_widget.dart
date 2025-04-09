import 'package:arta_app/core/constants/text.dart';
import 'package:flutter/material.dart';

class ProfileListTileWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  final Color color;
  final VoidCallback onTap;
  final bool showArrow;

  const ProfileListTileWidget({
    Key? key,
    required this.title,
    required this.imagePath,
    this.color = Colors.black,
    required this.onTap,
    this.showArrow = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(imagePath),
      title: Text(
        title,
        style: TextStyles.smallReguler,
      ),
      trailing: showArrow ? Icon(Icons.arrow_forward_ios, size: 16) : null,
      onTap: onTap,
    );
  }
}
