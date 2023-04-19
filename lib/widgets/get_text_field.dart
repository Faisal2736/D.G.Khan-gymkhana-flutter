import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../extras/colors.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String hint;
  final bool obsText;
  final int? lines;
  final List<TextInputFormatter>? inputFormatters;

  const TextFieldWidget(
      {Key? key,
      required this.hint,
      required this.controller,
      this.lines = 1,
      this.obsText = false,
      this.keyboardType,
      this.inputFormatters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 45.h,
      decoration: BoxDecoration(
        color: CColors.textFieldFill,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextFormField(
        obscureText: obsText,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        controller: controller,
        minLines: lines,
        maxLines: lines,
        style: TextStyle(
          color: CColors.fieldText,
          fontSize: 16.w,
        ),
        decoration: InputDecoration(
          hintText: hint,
          isDense: true,
          hintStyle: TextStyle(
            color: CColors.fieldText,
            fontSize: 16.w,
          ),
          contentPadding: EdgeInsets.only(left: 14.w, top: 16.h, bottom: 16.h),
          fillColor: CColors.textFieldFill,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CColors.textFieldFill, width: 1.0),
            borderRadius: BorderRadius.circular(7.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CColors.textFieldFill, width: 1.0),
            borderRadius: BorderRadius.circular(7.0),
          ),
        ),
      ),
    );
  }
}
