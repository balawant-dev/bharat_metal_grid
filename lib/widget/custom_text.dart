import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight weight;
  final Color? color;
  final TextAlign? align; // <-- added property

  const CustomText(
      this.text, {
        super.key,
        this.size = 14,
        this.weight = FontWeight.w400,
        this.color,
        this.align, // <-- added property
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align, // <-- use here
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color ?? Theme.of(context).textTheme.bodyLarge!.color,
      ),
    );
  }
}
