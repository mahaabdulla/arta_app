import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/feature/presentations/pages/home/presention/widgets/see_more_listing_view.dart';
import 'package:flutter/material.dart';

class SeeMoreButtom extends StatelessWidget {
  // final VoidCallback onTap;
  final String text;

  const SeeMoreButtom({
    super.key,
    // required this.onTap,
    this.text = 'مشاهدة المزيد',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: InkWell(
          onTap: () {
            // Show all categories or implement logic
            Navigator.push(context,
                MaterialPageRoute(builder: (ctx) => SeeMoreListingView()));
          },
          child: Container(
            height: 50,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff257A9E),
                  Color(0xff4F8982),
                ],
              ),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyles.smallReguler.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
