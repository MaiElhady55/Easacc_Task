import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easacc_task/core/constants/app_assets.dart';
import 'package:easacc_task/core/constants/app_colors.dart';
import 'package:easacc_task/core/constants/app_text_styles.dart';

class CustomDropDownField extends StatelessWidget {
  final List<DropdownMenuItem<String>> items;
  final String hintText;
  final TextStyle? hintStyle;
  final void Function(String?) onChanged;
  final String? Function(String? value)? validator;
  final String? value;
  final AutovalidateMode? autoValidateMode;
  final double? bordersRaduis,borderWidth;
  final Color? filledColor;
  final EdgeInsetsGeometry? contentPadding;

  const CustomDropDownField(
      {super.key,
      required this.items,
      required this.onChanged,
      required this.value,
      required this.hintText,
      this.validator,
      this.hintStyle,
      this.autoValidateMode,
      this.borderWidth,
      this.bordersRaduis,
      this.filledColor,
      this.contentPadding
      });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      dropdownColor: AppColors.whiteColor,
      value: value,
      items: items,
      hint: Text(
        hintText,
        style: hintStyle ??
            AppTextStyles.textStyle10.copyWith(
              color: AppColors.greyColor,
              fontWeight: FontWeight.w400,
            ),
      ),
      validator: validator,
      isDense: true,
      iconSize: 26.r,
      autovalidateMode: autoValidateMode,
      iconEnabledColor: AppColors.greyLightColor,
      borderRadius: BorderRadius.circular(bordersRaduis ?? 12.r),
      padding: EdgeInsets.zero,
      decoration: InputDecoration(
        isDense: true,
        border: buildOutlineInputBorder(),
        enabledBorder: buildOutlineInputBorder(),
        errorBorder: buildOutlineInputBorder(AppColors.redColor),
        focusedErrorBorder: buildOutlineInputBorder(AppColors.redColor),
        errorStyle: AppTextStyles.textStyle10.copyWith(
          color: AppColors.redColor,
        ),
        hintStyle: hintStyle ??
            AppTextStyles.textStyle12.copyWith(
              color: AppColors.greyColor,
              fontWeight: FontWeight.w500,
            ),
        contentPadding:contentPadding?? EdgeInsetsDirectional.only(
          top: 9.h,
          bottom: 9.h,
          end: 15.w,
          start: 15.w,
        ),
        focusedBorder: buildOutlineInputBorder(AppColors.primaryColor),
        filled: true,
        fillColor: filledColor ?? AppColors.whiteColor,
      ),
      onChanged: onChanged,
      icon: SvgPicture.asset(
        AppAssets.arrowDown,
        height: 22.h,
        width: 22.w,
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder([Color? color]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(bordersRaduis ?? 4.r),
      borderSide: BorderSide(
        color: color ?? AppColors.borderLightColor,
        width: borderWidth??1.w
      ),
    );
  }
}
