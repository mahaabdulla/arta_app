import 'dart:io';
import 'package:arta_app/core/constants/text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImageContainer extends StatefulWidget {
  const AddImageContainer({super.key});

  @override
  _AddImageContainerState createState() => _AddImageContainerState();
}

class _AddImageContainerState extends State<AddImageContainer> {
  final List<File?> _images = [null, null, null, null];
  int? _mainImageIndex;

  Future<void> _pickImage(int index) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _images[index] = File(pickedFile.path);
        if (_mainImageIndex == null) {
          _mainImageIndex = index;
        }
      });
    }
  }

  Future<void> _captureImage(int index) async {
    final ImagePicker picker = ImagePicker();
    final XFile? capturedFile =
        await picker.pickImage(source: ImageSource.camera);

    if (capturedFile != null) {
      setState(() {
        _images[index] = File(capturedFile.path);
        if (_mainImageIndex == null) {
          _mainImageIndex = index;
        }
      });
    }
  }

  void _setMainImage(int index) {
    if (_images[index] != null) {
      setState(() {
        _mainImageIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color.fromARGB(255, 151, 180, 176),
            Color.fromARGB(255, 109, 158, 164),
            Color(0xff5D9AA1),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'رفع الصور',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          if (_mainImageIndex != null)
            Row(
              children: [
                const SizedBox(height: 10),
                Container(
                  height: 70,
                  width: 79,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    image: _images[_mainImageIndex!] != null
                        ? DecorationImage(
                            image: FileImage(_images[_mainImageIndex!]!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                ),
                SizedBox(width: 20),
                Text('حدد الصورة الرئيسية', style: TextStyles.smallReguler),
              ],
            ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(4, (index) {
              return GestureDetector(
                onTap: () {
                  if (_images[index] != null) {
                    _setMainImage(index); // تحديد الصورة الرئيسية
                  } else {
                    _pickImage(index); // إضافة صورة إذا كانت فارغة
                  }
                },
                onLongPress: () {
                  _captureImage(index); // التقاط صورة بالكاميرا
                },
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _mainImageIndex == index
                          ? Colors.blue
                          : Colors.transparent,
                      width: 2.0,
                    ),
                    image: _images[index] != null
                        ? DecorationImage(
                            image: FileImage(_images[index]!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _images[index] == null
                      ? const Icon(Icons.add_a_photo, color: Colors.black54)
                      : null,
                ),
              );
            }),
          ),
          SizedBox(height: 15),
          Text(
            'اضغط مطولًا للاتقاط صورة أو اضغط مره واحدة للاختيار من معرض الصور',
            style: TextStyles.reguler12,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
