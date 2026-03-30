// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image_cropper/image_cropper.dart';
//
// class CustomImagePicker extends StatefulWidget {
//   final Function(File file) onImageSelected;
//
//   const CustomImagePicker({super.key, required this.onImageSelected});
//
//   @override
//   State<CustomImagePicker> createState() => _CustomImagePickerState();
// }
//
// class _CustomImagePickerState extends State<CustomImagePicker> {
//   final ImagePicker _picker = ImagePicker();
//   File? selectedImage;
//
//   Future<void> _pickImage(ImageSource source) async {
//     final XFile? picked =
//     await _picker.pickImage(source: source, imageQuality: 80);
//
//     if (picked != null) {
//       File? cropped = await _cropImage(File(picked.path));
//
//       if (cropped != null) {
//         setState(() {
//           selectedImage = cropped;
//         });
//
//         widget.onImageSelected(cropped);
//       }
//     }
//   }
//
//   Future<File?> _cropImage(File file) async {
//     CroppedFile? croppedFile = await ImageCropper().cropImage(
//       sourcePath: file.path,
//       compressQuality: 80,
//       uiSettings: [
//         AndroidUiSettings(
//           toolbarTitle: 'Crop Image',
//           toolbarColor: Colors.black,
//           toolbarWidgetColor: Colors.white,
//           lockAspectRatio: false,
//         ),
//         IOSUiSettings(
//           title: 'Crop Image',
//         ),
//       ],
//     );
//
//     if (croppedFile != null) {
//       return File(croppedFile.path);
//     }
//     return null;
//   }
//
//   void _showPicker() {
//     showModalBottomSheet(
//       context: context,
//       builder: (_) => SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: const Icon(Icons.camera_alt),
//               title: const Text("Camera"),
//               onTap: () {
//                 Navigator.pop(context);
//                 _pickImage(ImageSource.camera);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.photo),
//               title: const Text("Gallery"),
//               onTap: () {
//                 Navigator.pop(context);
//                 _pickImage(ImageSource.gallery);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _showPicker,
//       child: Stack(
//         children: [
//           CircleAvatar(
//             radius: 50,
//             backgroundColor: Colors.grey.shade200,
//             backgroundImage: selectedImage != null
//                 ? FileImage(selectedImage!)
//                 : const AssetImage("assets/images/appLogo.png")
//             as ImageProvider,
//           ),
//           Positioned(
//             bottom: 0,
//             right: 0,
//             child: CircleAvatar(
//               radius: 14,
//               backgroundColor: Colors.blue,
//               child: const Icon(Icons.camera_alt,
//                   size: 16, color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

enum ImageShape { circle, rectangle }

class CustomImagePicker extends StatefulWidget {
  final Function(File file) onImageSelected;

  final ImageShape shape;
  final double? width;
  final double? height;
  final double borderRadius;

  /// Crop ratio (example: 1:1 = square, 16:9 = banner)
  final double? ratioX;
  final double? ratioY;

  const CustomImagePicker({
    super.key,
    required this.onImageSelected,
    this.shape = ImageShape.circle,
    this.width,
    this.height,
    this.borderRadius = 12,
    this.ratioX,
    this.ratioY,
  });

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    final XFile? picked =
    await _picker.pickImage(source: source, imageQuality: 80);

    if (picked != null) {
      File? cropped = await _cropImage(File(picked.path));

      if (cropped != null) {
        setState(() {
          selectedImage = cropped;
        });

        widget.onImageSelected(cropped);
      }
    }
  }

  Future<File?> _cropImage(File file) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      compressQuality: 80,
      aspectRatio: (widget.ratioX != null && widget.ratioY != null)
          ? CropAspectRatio(ratioX: widget.ratioX!, ratioY: widget.ratioY!)
          : null,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: widget.ratioX != null,
        ),
        IOSUiSettings(title: 'Crop Image'),
      ],
    );

    if (croppedFile != null) {
      return File(croppedFile.path);
    }
    return null;
  }

  void _showPicker() {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text("Gallery"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    /// 📌 Circle UI
    if (widget.shape == ImageShape.circle) {
      imageWidget = CircleAvatar(
        radius: widget.width ?? 50,
        backgroundColor: Colors.grey.shade200,
        backgroundImage: selectedImage != null
            ? FileImage(selectedImage!)
            : const AssetImage("assets/images/appLogo.png")
        as ImageProvider,
      );
    }

    /// 📌 Rectangle / Square UI
    else {
      imageWidget = Container(
        width: widget.width ?? 120,
        height: widget.height ?? 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          color: Colors.grey.shade200,
          image: DecorationImage(
            image: selectedImage != null
                ? FileImage(selectedImage!)
                : const AssetImage("assets/images/upload_icon_banner.png")
            as ImageProvider,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: _showPicker,
      child: Stack(
        children: [
          imageWidget,
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: const Icon(Icons.camera_alt,
                  size: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}


//. Banner Image (Rectangle 16:9)
// CustomImagePicker(
// shape: ImageShape.rectangle,
// width: double.infinity,
// height: 160,
// ratioX: 16,
// ratioY: 9,
// onImageSelected: (file) {
// selectedImage = file;
// },
// )
//2. Product Image (Square)
// CustomImagePicker(
// shape: ImageShape.rectangle,
// width: 120,
// height: 120,
// ratioX: 1,
// ratioY: 1, // square crop
// onImageSelected: (file) {
// selectedImage = file;
// },
// )

//1. Profile Image (Circle)

//CustomImagePicker(
//   shape: ImageShape.circle,
//   width: 50,
//   onImageSelected: (file) {
//     selectedImage = file;
//   },
// )