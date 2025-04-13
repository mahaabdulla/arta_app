import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            /// الجزء العلوي: صورة الخلفية، صورة الملف الشخصي، زر الرجوع
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  /// صورة الخلفية
                  Positioned.fill(
                    child: Image.asset(
                      "assets/png_images/Group 9276.png",
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(color: Colors.grey);
                      },
                    ),
                  ),

                  Positioned(
                    top: 30.h,
                    right: 20.h,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.popAndPushNamed(context, "/home");
                        },
                        child: Image.asset('assets/png_images/icon-notif.png')),
                  ),

                  /// صورة الملف الشخصي + أيقونة الكاميرا داخل `Stack`
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: 50.r,
                          backgroundColor: Colors.grey.shade300,
                          backgroundImage: _profileImage != null
                              ? FileImage(_profileImage!)
                              : null,
                          child: _profileImage == null
                              ? Icon(Icons.person,
                                  size: 50.w, color: Colors.white70)
                              : null,
                        ),

                        /// أيقونة الكاميرا في الزاوية اليمنى السفلى
                        Positioned(
                          bottom: 0,
                          right: -10, // للتحكم في موقع الأيقونة
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
                ],
              ),
            ),

            /// الجزء السفلي: محتوى الصفحة (الـ `child`)
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.r)),
                ),
                child: SingleChildScrollView(
                  child: widget.child,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
