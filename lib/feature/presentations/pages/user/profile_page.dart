import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  Future<void> _handleLogout(BuildContext context) async {
    // حذف بيانات المستخدم من SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // العودة إلى صفحة تسجيل الدخول
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login',
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // صورة الخلفية
            Container(
              height: 200.h,
              width: double.infinity,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/png_images/Group 9276.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r),
                ),
              ),
              child: Stack(
                children: [
                  // زر الرجوع
                  Positioned(
                    top: 10.h,
                    right: 10.w,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  // صورة الملف الشخصي
                  Positioned(
                    bottom: -5.h,
                    left: 0,
                    right: 0,
                    child: Stack(
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 50.r,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 45.r,
                              backgroundColor: Colors.grey[200],
                              child: _profileImage != null
                                  ? ClipOval(
                                      child: Image.file(
                                        _profileImage!,
                                        width: 90.r,
                                        height: 90.r,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Icon(
                                      Icons.person,
                                      size: 50.r,
                                      color: Colors.grey[400],
                                    ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: MediaQuery.of(context).size.width / 2 - 30.w,
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: Colors.teal,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 100.h),
            // قائمة الخيارات
            Container(
              margin: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                bottom: 20.h,
              ),
              height: 400.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: ListView(
                padding: EdgeInsets.all(16.w),
                children: [
                  _buildMenuItem(
                    icon: Icons.person_outline,
                    title: 'تعديل المعلومات الشخصية',
                    onTap: () {
                      // التنقل إلى صفحة تعديل المعلومات
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.language,
                    title: 'اللغة',
                    onTap: () {
                      // التنقل إلى صفحة اللغة
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.help_outline,
                    title: 'المساعدة والدعم',
                    onTap: () {
                      // التنقل إلى صفحة المساعدة
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.description_outlined,
                    title: 'الأحكام والشروط',
                    onTap: () {
                      // التنقل إلى صفحة الأحكام
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.logout,
                    title: 'تسجيل الخروج',
                    onTap: () => _handleLogout(context),
                    showArrow: false,
                    textColor: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool showArrow = true,
    Color textColor = Colors.black,
  }) {
    return ListTile(
      leading: Icon(icon, color: textColor),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: showArrow
          ? Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.grey)
          : null,
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey.withOpacity(0.2),
      height: 1,
    );
  }
} 