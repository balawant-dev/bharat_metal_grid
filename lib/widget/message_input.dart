import 'package:bharat_metal_grid/widget/utils/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../app/theme/color_resource.dart';
import 'custom_image_view.dart';

class MessageInputBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  final String hintText;
  final String imagePath;

  const MessageInputBox({
    super.key,
    required this.controller,
    required this.onSend,
    this.hintText = "Write Your Message",
    this.imagePath = AppImages.send,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: ColorResource.white,
        borderRadius: BorderRadius.circular(6),



        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          Expanded(
              child: TextField(
                controller: controller,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                decoration: const InputDecoration(
                  hintText: "Write Your Message",
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                  border: InputBorder.none,
                  isCollapsed: true,
                  contentPadding: EdgeInsets.zero,
                ),
              )
          ),
          GestureDetector(
            onTap: onSend,
            child: CustomImageView(
              imagePath: imagePath,
              height: 24,
              width: 24,
            ),
          ),
        ],
      ),
    );
  }
}
