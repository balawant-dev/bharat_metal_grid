//
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// class CommonTextFormField extends StatelessWidget {
//   final TextEditingController? controller;
//   final String? hintText;
//   final String? labelText;
//   final String? helperText;
//   final String? counterText;
//
//   final IconData? prefixIcon;
//   final Widget? suffixIcon;
//   final Widget? customSuffix;
//
//   final String? Function(String?)? validator;
//   final String? regexPattern;
//   final String? regexErrorMessage;
//
//   final Function(String)? onChanged;
//   final Function(String)? onFieldSubmitted;
//   final VoidCallback? onTap;
//   final Function(String?)? onSaved;
//
//   final TextInputType? keyboardType;
//   final TextInputAction? textInputAction;
//   final int? maxLines;
//   final int? minLines;
//   final int? maxLength;
//   final bool obscureText;
//   final bool isDisabled; // नया: disable करने के लिए
//   final bool readOnly;
//   final bool autofocus;
//
//   final double height;
//   final Color? backgroundColor;
//   final Color? borderColor;
//   final double borderRadius;
//
//   const CommonTextFormField({
//     super.key,
//     this.controller,
//     this.hintText,
//     this.labelText,
//     this.helperText,
//     this.counterText,
//     this.prefixIcon,
//     this.suffixIcon,
//     this.customSuffix,
//     this.validator,
//     this.regexPattern,
//     this.regexErrorMessage = 'Invalid format',
//     this.onChanged,
//     this.onFieldSubmitted,
//     this.onTap,
//     this.onSaved,
//     this.keyboardType,
//     this.textInputAction,
//     this.maxLines = 1,
//     this.minLines,
//     this.maxLength,
//     this.obscureText = false,
//     this.isDisabled = false,        // default enabled
//     this.readOnly = false,
//     this.autofocus = false,
//     this.height = 46.0,
//     this.backgroundColor = Colors.white,
//     this.borderColor,
//     this.borderRadius = 12.0,
//   });
//
//   String? _regexValidator(String? value) {
//     if (value == null || value.isEmpty) return null;
//     if (regexPattern != null) {
//       final regExp = RegExp(regexPattern!);
//       if (!regExp.hasMatch(value.trim())) return regexErrorMessage;
//     }
//     return null;
//   }
//
//   String? _getValidator(String? value) {
//     if (validator != null) {
//       final result = validator!(value);
//       if (result != null) return result;
//     }
//     return _regexValidator(value);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final Color effectiveBorderColor = borderColor ?? const Color(0xffDBDBDB);
//
//     return Container(
//       height: height,
//       decoration: BoxDecoration(
//         color: backgroundColor,
//       //  color: isDisabled ? Colors.grey.shade100 : backgroundColor,
//         border: Border.all(
//           color: effectiveBorderColor,
//           width: 1,
//         ),
//         borderRadius: BorderRadius.circular(borderRadius),
//       ),
//       child: TextFormField(
//
//         controller: controller,
//         keyboardType: keyboardType,
//         textInputAction: textInputAction,
//         maxLines: maxLines,
//         minLines: minLines,
//         maxLength: maxLength,
//         obscureText: obscureText,
//         enabled: !isDisabled, // important: control via enabled
//         readOnly: readOnly || isDisabled, // extra safety
//         autofocus: autofocus,
//         onChanged: isDisabled ? null : onChanged,
//         onFieldSubmitted: isDisabled ? null : onFieldSubmitted,
//         onTap: isDisabled ? () {} : onTap, // prevent focus if disabled
//         onSaved: onSaved,
//         validator: _getValidator,
//         style: TextStyle(
//           fontSize: 14,
//           color: isDisabled ? Colors.grey.shade600 : Colors.black,
//         ),
//         decoration: InputDecoration(
//           filled: false,
//           // Specify the background color
//           //fillColor: Colors.blue[50], // Example color: a light blue shade
//           hintText: hintText,
//           labelText: labelText,
//           helperText: helperText,
//           counterText: counterText ?? "",
//           prefixIcon: prefixIcon != null
//               ? Padding(
//             padding: const EdgeInsets.only(left: 10),
//             child: Icon(
//               prefixIcon,
//               size: 20,
//               color: isDisabled ? Colors.grey.shade500 : Colors.black54,
//             ),
//           )
//               : null,
//           suffixIcon: customSuffix ?? suffixIcon,
//           border: InputBorder.none,
//           enabledBorder: InputBorder.none,     // important
//           disabledBorder: InputBorder.none,    // important - यही problem solve करता है
//           focusedBorder: InputBorder.none,
//           errorBorder: InputBorder.none,
//           focusedErrorBorder: InputBorder.none,
//           contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//           hintStyle: TextStyle(
//             color: isDisabled ? Colors.grey.shade500 : Colors.black54,
//             fontSize: 13,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:bharat_metal_grid/app/theme/color_resource.dart';
import 'package:flutter/material.dart';

class CommonTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final String? counterText;

  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final Widget? customSuffix;

  final String? Function(String?)? validator;
  final String? regexPattern;
  final String? regexErrorMessage;

  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final VoidCallback? onTap;
  final Function(String?)? onSaved;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool obscureText;
  final bool isDisabled;
  final bool readOnly;
  final bool autofocus;

  final double height;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderRadius;

  const CommonTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.helperText,
    this.counterText,
    this.prefixIcon,
    this.suffixIcon,
    this.customSuffix,
    this.validator,
    this.regexPattern,
    this.regexErrorMessage = 'Invalid format',
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.onSaved,
    this.keyboardType,
    this.textInputAction,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.obscureText = false,
    this.isDisabled = false,
    this.readOnly = false,
    this.autofocus = false,
    this.height = 50.0,
    this.backgroundColor = Colors.white,
    this.borderColor,
    this.borderRadius = 12.0,
  });

  @override
  State<CommonTextFormField> createState() => _CommonTextFormFieldState();
}

class _CommonTextFormFieldState extends State<CommonTextFormField> {
  String? errorText;

  String? _regexValidator(String? value) {
    if (value == null || value.isEmpty) return null;
    if (widget.regexPattern != null) {
      final regExp = RegExp(widget.regexPattern!);
      if (!regExp.hasMatch(value.trim())) {
        return widget.regexErrorMessage;
      }
    }
    return null;
  }

  String? _getValidator(String? value) {
    if (widget.validator != null) {
      final result = widget.validator!(value);
      if (result != null) return result;
    }
    return _regexValidator(value);
  }

  @override
  Widget build(BuildContext context) {
    final Color effectiveBorderColor =
        errorText != null
            ? Colors.red
            : (widget.borderColor ?? const Color(0xffDBDBDB));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.hintText ?? "",style: TextStyle(fontSize: 12,color: Colors.black),),
        SizedBox(height: 5,),

        /// TEXT FIELD
        Container(
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            border: Border.all(color: effectiveBorderColor),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          child: TextFormField(
            cursorColor: ColorResource.primaryColor,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            maxLength: widget.maxLength,
            obscureText: widget.obscureText,
            enabled: !widget.isDisabled,
            readOnly: widget.readOnly || widget.isDisabled,
            autofocus: widget.autofocus,
            onTap: widget.isDisabled ? () {} : widget.onTap,
            onFieldSubmitted:
                widget.isDisabled ? null : widget.onFieldSubmitted,
            onSaved: widget.onSaved,
            onChanged: (value) {
              setState(() {
                errorText = _getValidator(value);
              });
              widget.onChanged?.call(value);
            },
            style: TextStyle(
              fontSize: 14,
              color: widget.isDisabled ? Colors.grey.shade600 : Colors.black,
            ),
            decoration: InputDecoration(
              filled: false,
              hintText: widget.hintText,

              helperText: widget.helperText,
              counterText: widget.counterText ?? "",
              prefixIcon:
                  widget.prefixIcon != null
                      ? Padding(
                        padding: const EdgeInsets.only(left: 1),
                        child: Icon(
                          widget.prefixIcon,
                          size: 20,
                          color:
                              widget.isDisabled
                                  ? Colors.grey.shade500
                                  : Colors.black54,
                        ),
                      )
                      : null,
              suffixIcon: widget.customSuffix ?? widget.suffixIcon,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              errorText: null,
              // 🔴 IMPORTANT: field ke andar error band
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
            ),
          ),
        ),

        /// ERROR TEXT (FIELD KE NICHE)
        if (errorText != null) ...[
          const SizedBox(height: 4),
          Text(
            errorText!,
            style: const TextStyle(color: Colors.red, fontSize: 12),
          ),
        ],
      ],
    );
  }
}
