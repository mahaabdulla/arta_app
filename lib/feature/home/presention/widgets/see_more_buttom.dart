import 'package:arta_app/core/constants/text.dart';
import 'package:flutter/material.dart';

class SeeMoreButtom extends StatelessWidget {
  const SeeMoreButtom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: InkWell(
            onTap: () {
              // Show all categories or implement logic
              Navigator.pushNamed(context, '/my_ads');
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
                    ]),
              ),
              child: Center(
                child: Text('مشاهدة المزيد',
                    style:
                        TextStyles.smallReguler.copyWith(color: Colors.white)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
