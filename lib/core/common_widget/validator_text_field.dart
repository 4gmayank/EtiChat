import 'package:eti_chat/core/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class ValidateTextField extends StatelessWidget {
  final controller;
  final String? hintText;
  final int? maxLine;
  final List<TextInputFormatter>? inputFormatters;

  //final String lableText;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final FormFieldValidator? validate;
  final suffixIcon;
  final double bottomMargin;
  final Color background;
  final TextInputAction? textInputAction;
  final Function? onTap;
  final bool readOnly;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(.38),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Container(
        child: TextFormField(
          textInputAction: textInputAction,
          textCapitalization: textCapitalization,
          onTap: () {
            if (onTap != null) {
              onTap!();
            }
          },
          autocorrect: false,
          cursorColor: AppColors.black,
          maxLines: maxLine,
          readOnly: readOnly,
          inputFormatters: inputFormatters ?? <TextInputFormatter>[
                  if (keyboardType == TextInputType.number)
                    FilteringTextInputFormatter.digitsOnly,
                ],
          validator: validate,
          keyboardType: keyboardType,
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: readOnly ? AppColors.greyOut : background,
            contentPadding: EdgeInsets.only(left: 12.0),
            hintText: hintText,
            suffixIcon: suffixIcon,
            hintStyle: AppFonts.lightStyle(
              fontSize: 12.0,
              fontColor: AppColors.hintTextLight,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            border: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  ValidateTextField({
    Key? key,
    this.hintText = '',
    this.maxLine,
    this.obscureText = false,
    this.controller,
    this.suffixIcon,
    this.onTap,
    this.textInputAction,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.words,
    this.validate,
    this.bottomMargin = 30.0,
    this.background = AppColors.white,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
  }) : super(key: key);
}
