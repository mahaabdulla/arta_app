import 'dart:io';
import 'package:arta_app/core/constants/text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImageContainer extends StatefulWidget {
  final Function(List<File?> images, File? primaryImage) onImagesUpdated;
  final List<String>? initialImages; // روابط الصور الجاهزة، لو فيه إعلان قديم

  const AddImageContainer({
    required this.onImagesUpdated,
    this.initialImages,
    super.key,
  });

  @override
  _AddImageContainerState createState() => _AddImageContainerState();
}

class _AddImageContainerState extends State<AddImageContainer> {
  final List<File?> _images = [null, null, null, null];
  int? _mainImageIndex;

  @override
  void initState() {
    super.initState();
    if (widget.initialImages != null) {
      for (int i = 0;
          i < widget.initialImages!.length && i < _images.length;
          i++) {
        final path = widget.initialImages![i];
        if (!path.startsWith('http')) {
          _images[i] = File(path);
        }
      }
    }
  }

  void _notifyParent() {
    final File? primary =
        _mainImageIndex != null ? _images[_mainImageIndex!] : null;
    widget.onImagesUpdated(_images, primary);
  }

  Future<void> _pickImage(int index) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _images[index] = File(pickedFile.path);
        _mainImageIndex ??= index;
        _notifyParent();
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
        _mainImageIndex ??= index;
        _notifyParent();
      });
    }
  }

  void _setMainImage(int index) {
    if (_images[index] != null) {
      setState(() {
        _mainImageIndex = index;
        _notifyParent();
      });
    }
  }

  DecorationImage? _buildImage(int index) {
    final localFile = _images[index];
    final url =
        widget.initialImages != null && index < widget.initialImages!.length
            ? widget.initialImages![index]
            : null;

    if (localFile != null) {
      return DecorationImage(image: FileImage(localFile), fit: BoxFit.cover);
    } else if (url != null && url.startsWith('http')) {
      return DecorationImage(image: NetworkImage(url), fit: BoxFit.cover);
    }
    return null;
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
          Text('رفع الصور',
              style: TextStyles.medium22
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.black)),
          const SizedBox(height: 16.0),
          if (_mainImageIndex != null)
            Row(
              children: [
                Container(
                  height: 70,
                  width: 79,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black),
                    image: _buildImage(_mainImageIndex!),
                  ),
                ),
                const SizedBox(width: 20),
                Text('الصورة الرئيسية', style: TextStyles.smallReguler),
              ],
            ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(4, (index) {
              return GestureDetector(
                onTap: () {
                  if (_images[index] != null) {
                    _setMainImage(index);
                  } else {
                    _pickImage(index);
                  }
                },
                onLongPress: () => _captureImage(index),
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
                    image: _buildImage(index),
                  ),
                  child: (_images[index] == null &&
                          (widget.initialImages == null ||
                              widget.initialImages!.length <= index))
                      ? const Icon(Icons.add_a_photo, color: Colors.black54)
                      : null,
                ),
              );
            }),
          ),
          const SizedBox(height: 15),
          Text(
            'اضغط مطولًا لالتقاط صورة أو اضغط لاختيار من المعرض',
            style: TextStyles.reguler12,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// class AddImageContainer extends StatefulWidget {
//   final Function(List<File?>) onImagesUpdated; // Callback لتمرير الصور

//   const AddImageContainer({
//     required this.onImagesUpdated, // تمرير الدالة في الإنشاء
//     super.key,
//   });

//   @override
//   _AddImageContainerState createState() => _AddImageContainerState();
// }

// class _AddImageContainerState extends State<AddImageContainer> {
//   final List<File?> _images = [null, null, null, null];
//   int? _mainImageIndex;

//   Future<void> _pickImage(int index) async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? pickedFile =
//         await picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _images[index] = File(pickedFile.path);
//         if (_mainImageIndex == null) {
//           _mainImageIndex = index;
//         }
//         widget.onImagesUpdated(_images); // تمرير الصور إلى الواجهة الأساسية
//       });
//     }
//   }

//   Future<void> _captureImage(int index) async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? capturedFile =
//         await picker.pickImage(source: ImageSource.camera);

//     if (capturedFile != null) {
//       setState(() {
//         _images[index] = File(capturedFile.path);
//         if (_mainImageIndex == null) {
//           _mainImageIndex = index;
//         }
//         widget.onImagesUpdated(_images); // تمرير الصور إلى الواجهة الأساسية
//       });
//     }
//   }

//   void _setMainImage(int index) {
//     if (_images[index] != null) {
//       setState(() {
//         _mainImageIndex = index;
//         widget.onImagesUpdated(_images); // تمرير الصور إلى الواجهة الأساسية
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         gradient: const LinearGradient(
//           begin: Alignment.bottomCenter,
//           end: Alignment.topCenter,
//           colors: [
//             Color.fromARGB(255, 151, 180, 176),
//             Color.fromARGB(255, 109, 158, 164),
//             Color(0xff5D9AA1),
//           ],
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'رفع الصور',
//             style: TextStyles.medium22.copyWith(
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//           const SizedBox(height: 16.0),
//           if (_mainImageIndex != null)
//             Row(
//               children: [
//                 const SizedBox(height: 10),
//                 Container(
//                   height: 70,
//                   width: 79,
//                   decoration: BoxDecoration(
//                     color: Colors.grey,
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(
//                       color: Colors.black,
//                       width: 1.0,
//                     ),
//                     image: _images[_mainImageIndex!] != null
//                         ? DecorationImage(
//                             image: FileImage(_images[_mainImageIndex!]!),
//                             fit: BoxFit.cover,
//                           )
//                         : null,
//                   ),
//                 ),
//                 const SizedBox(width: 20),
//                 Text('حدد الصورة الرئيسية', style: TextStyles.smallReguler),
//               ],
//             ),
//           const SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: List.generate(4, (index) {
//               return GestureDetector(
//                 onTap: () {
//                   if (_images[index] != null) {
//                     _setMainImage(index); // تحديد الصورة الرئيسية
//                   } else {
//                     _pickImage(index); // إضافة صورة إذا كانت فارغة
//                   }
//                 },
//                 onLongPress: () {
//                   _captureImage(index); // التقاط صورة بالكاميرا
//                 },
//                 child: Container(
//                   height: 70,
//                   width: 70,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[300],
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(
//                       color: _mainImageIndex == index
//                           ? Colors.blue
//                           : Colors.transparent,
//                       width: 2.0,
//                     ),
//                     image: _images[index] != null
//                         ? DecorationImage(
//                             image: FileImage(_images[index]!),
//                             fit: BoxFit.cover,
//                           )
//                         : null,
//                   ),
//                   child: _images[index] == null
//                       ? const Icon(Icons.add_a_photo, color: Colors.black54)
//                       : null,
//                 ),
//               );
//             }),
//           ),
//           const SizedBox(height: 15),
//           Text(
//             'اضغط مطولًا لالتقاط صورة أو اضغط مرة واحدة للاختيار من معرض الصور',
//             style: TextStyles.reguler12,
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }
