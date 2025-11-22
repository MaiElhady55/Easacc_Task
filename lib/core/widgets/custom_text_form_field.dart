import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:cake_app/core/constants/app_assets.dart';
import 'package:easacc_task/core/constants/app_colors.dart';
import 'package:easacc_task/core/constants/app_fonts.dart';
import 'package:easacc_task/core/constants/app_text_styles.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? ctrl;
  final String? hintText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon, prefixIcon;
  final String? Function(String? value)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool? isPass, readOnly;
  final bool isSearch;
  final int? maxLines;
  final Color? filledColor;
  final TextStyle? textStyle, hintStyle;
  final double? borderRadiusValue, borderWidth, errorFontSize;
  final EdgeInsetsGeometry? contentPadding;
  final Color? focusedBorderColor;
  final void Function(String)? onChanged;
  final void Function()? onTap;

  final AutovalidateMode? autoValidateMode;

  const CustomTextFormField({
    super.key,
    this.ctrl,
    this.hintText,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.suffixIcon,
    this.filledColor,
    this.prefixIcon,
    this.textStyle,
    this.errorFontSize,
    this.focusedBorderColor,
    this.readOnly = false,
    this.isPass = false,
    this.isSearch = false,
    this.maxLines = 1,
    this.borderWidth,
    this.autoValidateMode,
    this.onChanged,
    this.hintStyle,
    this.onTap,
    this.borderRadiusValue,
    this.contentPadding,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isVisible = true;

  void changeVisibility() {
    isVisible = !isVisible;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      obscureText: widget.isPass == true && isVisible == true,
      controller: widget.ctrl,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      onTap: widget.onTap,
      scrollPadding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      style: widget.textStyle ?? AppTextStyles.textStyle14,
      inputFormatters: widget.inputFormatters,
      readOnly: widget.readOnly!,
      validator: widget.validator,
      maxLines: widget.maxLines,
      autovalidateMode: widget.autoValidateMode,
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.filledColor ?? AppColors.whiteColor,
        border: buildOutlineInputBorder(),
        suffixIcon: widget.suffixIcon,

        
        prefixIcon: widget.prefixIcon,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ??
            AppTextStyles.textStyle10.copyWith(
              color: AppColors.greyColor,
              fontWeight: FontWeight.w400,
            ),
        focusedBorder: buildOutlineInputBorder(
            widget.focusedBorderColor ?? AppColors.primaryColor),
        enabledBorder: buildOutlineInputBorder(widget.isSearch
            ? AppColors.strokeColor
            : widget.focusedBorderColor ?? null),
        errorBorder: buildOutlineInputBorder(AppColors.redColor),
        focusedErrorBorder: buildOutlineInputBorder(AppColors.redColor),
        errorStyle: AppTextStyles.textStyle10.copyWith(
          color: AppColors.redColor,
          fontSize: widget.errorFontSize ?? AppFonts.t10,
        ),
        contentPadding: widget.contentPadding ??
            EdgeInsets.symmetric(vertical: 12.h, horizontal: 15.w),
        isDense: true,
      ),
      onChanged: widget.onChanged,
    );
  }

  OutlineInputBorder buildOutlineInputBorder([Color? color]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadiusValue ?? 4.r),
      borderSide: BorderSide(
          color: color ?? AppColors.greyLightColor,
          width: widget.borderWidth ?? 1),
    );
  }
}
