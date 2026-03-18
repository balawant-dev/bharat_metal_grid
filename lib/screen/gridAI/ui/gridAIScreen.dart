

import 'package:bharat_metal_grid/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../widget/customAppbar.dart';


class GridAiScreen extends StatefulWidget {
  const GridAiScreen({super.key});

  @override
  State<GridAiScreen> createState() => _GridAiScreenState();
}

class _GridAiScreenState extends State<GridAiScreen> {
  TextEditingController remarkController = TextEditingController();

  final List<GridAiModel> gridAiData = [
    GridAiModel(title: 'Can I trust the predictions and analysis on LifeGuru?'),
    GridAiModel(title: 'How accurate are the AI based suggestions provided here?'),
    GridAiModel(title: 'What data sources does Grid AI use for insights?'),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Events',   showBackButton: true,
        isHome: true,),
      body: Center(
        child: Text("Event Comming Soon"),
      ),
    );
  }

  Widget AiCardData({required String title}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFF181818),
                fontSize: 14,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w600,
                height: 1.29,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: const Color(0xFF164299),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.white,size: 18,),
            ),
          )
        ],
      ),
    );
  }
}


class GridAiModel {
  final String title;

  GridAiModel({required this.title});
}

class CustomInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool readOnly;
  final VoidCallback? onTap;

  final int? minLength;
  final int? maxLength;
  final bool digitsOnly;

  final Widget? suffixIcon;
  final VoidCallback? onSuffixTap;

  final int maxLines;

  const CustomInputField({
    super.key,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.onTap,
    this.minLength,
    this.maxLength,
    this.digitsOnly = false,
    this.suffixIcon,
    this.onSuffixTap,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1),
      width: double.infinity,


      height: maxLines == 1 ? 50 : null,

      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly,
        onTap: onTap,
        maxLength: maxLength,


        maxLines: maxLines,
        minLines: maxLines,

        inputFormatters: [
          if (digitsOnly) FilteringTextInputFormatter.digitsOnly,
          if (maxLength != null)
            LengthLimitingTextInputFormatter(maxLength),
        ],
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'Poppins',
        ),
        decoration: InputDecoration(
          counterText: "",
          border: InputBorder.none,
          hintText: hintText,


          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 12,
          ),

          suffixIcon: suffixIcon != null
              ? InkWell(
            onTap: onSuffixTap,
            child: SizedBox(
              width: 30,
              height: 30,
              child: Center(child: suffixIcon),
            ),
          )
              : null,

          hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.5),
            fontSize: 12,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            letterSpacing: 0.24,
          ),
        ),
      ),
    );
  }

  bool isValid() {
    if (minLength != null && controller.text.length < minLength!) {
      return false;
    }
    if (maxLength != null && controller.text.length > maxLength!) {
      return false;
    }
    return true;
  }
}

