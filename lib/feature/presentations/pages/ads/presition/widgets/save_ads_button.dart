
import 'package:arta_app/core/constants/text.dart';
import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback onTap;

  const SaveButton({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(top: 30, bottom: 20),
          width: 250,
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xff055479),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              'حفظ ونشر الاعلان',
              style: TextStyles.medium22.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
