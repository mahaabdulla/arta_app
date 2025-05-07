import 'package:arta_app/core/constants/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isLoading;

  const SaveButton({
    required this.onTap,
    this.isLoading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: isLoading ? null : onTap,
        child: Container(
          margin: const EdgeInsets.only(top: 30, bottom: 20),
          width: double.infinity,
          height: 60.h,
          decoration: BoxDecoration(
            color: const Color(0xff055479),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    'حفظ ونشر الاعلان',
                    style: TextStyles.medium22.copyWith(color: Colors.white),
                  ),
          ),
        ),
      ),
    );
  }
}
