import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:arta_app/core/constants/svg_images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScaffold extends StatefulWidget {
  final Widget child;

  const ProfileScaffold({super.key, required this.child});

  @override
  _ProfileScaffoldState createState() => _ProfileScaffoldState();
}

class _ProfileScaffoldState extends State<ProfileScaffold> {
  File? _profileImage;

  Future<void> showImageSourceDialog() async {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(16.w),
        height: 150.h,
        child: Column(
          children: [
            Text(
              "اختر مصدر الصورة",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                  icon: Icon(Icons.camera, size: 20.w),
                  label: Text("الكاميرا", style: TextStyle(fontSize: 14.sp)),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                  icon: Icon(Icons.image, size: 20.w),
                  label: Text("المعرض", style: TextStyle(fontSize: 14.sp)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Stack(
          children: [
            // bacground image
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 0.45.sh,
                child: SvgPicture.asset(
                  group1,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            /// زر الرجوع
            Positioned(
              top: 76.h,
              right: 40.w,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/home");
                },
                child: SvgPicture.asset(iconsArrow, width: 60.w, height: 60.h),
              ),
            ),

            /// profile image
            Positioned(
              top: 250.h,
              left: (1.sw - 100.w) / 2,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 50.r,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : null,
                    child: _profileImage == null
                        ? Icon(Icons.person, size: 50.w, color: Colors.white70)
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: showImageSourceDialog,
                      child: CircleAvatar(
                        backgroundColor: Colors.teal,
                        radius: 18.r,
                        child: Icon(Icons.camera_alt,
                            color: Colors.white, size: 18.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// محتوى الصفحة
            Positioned(
              top: 372.h,
              left: 0,
              right: 0,
              child: Container(
                height: 0.40.sh,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.r)),
                ),
                child: widget.child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
