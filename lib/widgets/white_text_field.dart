import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../extras/colors.dart';

class WhiteTextFieldWidget extends StatelessWidget {
  final Widget? suffixIcon;
  final TextEditingController textEditingController;
  final String? labelText;
  final Color? color;
  final Function(String value)? onDone;
  final String? hintText;
  final TextInputType? textInputType;
  final AlignmentGeometry? suffixAlignment;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final double? horizontalMargin;
  final Function(String)? onChanged;
  final double? borderRadius;
  final bool obscureText;
  final TextStyle? labelStyle;
  final FocusNode? node;
  final TextStyle? hintStyle;

  const WhiteTextFieldWidget({
    Key? key,
    this.suffixIcon,
    this.inputFormatters,
    this.labelText,
    this.borderRadius,
    required this.textEditingController,
    this.hintText,
    this.maxLines,
    this.suffixAlignment,
    required this.horizontalMargin,
    this.obscureText = false,
    this.onChanged,
    this.textInputType,
    this.color,
    this.labelStyle,
    this.hintStyle,
    this.onDone,
    this.node,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontalMargin ?? 37),
      // decoration: BoxDecoration(
      //     color: color ?? Colors.white,
      //     borderRadius: BorderRadius.circular(borderRadius ?? 12),
      //     boxShadow: [
      //       BoxShadow(
      //         blurRadius: 8,
      //         color: const Color(0xff000000).withAlpha(16),
      //         blurStyle: BlurStyle.outer,
      //         spreadRadius: 0,
      //         offset: const Offset(0, 0),
      //       ),
      //     ]),
      decoration: BoxDecoration(
        color: CColors.textFieldFill,
        borderRadius: BorderRadius.circular(5),
      ),

      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                focusNode: node,
                controller: textEditingController,
                // style: buildRobot(),
                maxLines: maxLines ?? 1,
                keyboardType: textInputType,
                onFieldSubmitted: onDone,
                obscureText: obscureText,
                style: TextStyle(
                  color: CColors.fieldText,
                  fontSize: 16,
                ),
                onChanged: onChanged,
                inputFormatters: inputFormatters,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: CColors.fieldText,
                    fontSize: 16,
                  ),
                  // hintStyle: hintStyle ?? buildRobot(),
                  // labelStyle: labelStyle ?? buildRobot(),
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: labelText,
                  border: InputBorder.none,
                  isDense: true,
                  fillColor: Colors.transparent,
                  filled: true,
                ),
              ),
            ),
            if (suffixIcon != null)
              Align(
                  alignment: suffixAlignment ?? Alignment.bottomRight,
                  child: suffixIcon!)
          ],
        ),
      ),
    );
  }

// TextStyle buildRobot() {
//   return AppTextStyle.robot(
//     style: TextStyle(color: CColors.textColorBlack),
//   );
// }

}
