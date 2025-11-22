import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easacc_task/core/constants/app_colors.dart';
import 'package:easacc_task/core/constants/app_constants.dart';
import 'package:easacc_task/core/constants/app_fonts.dart';
import 'package:easacc_task/core/constants/app_text_styles.dart';
import 'package:easacc_task/core/framework/spaces.dart';
import 'package:easacc_task/core/util/extensions/media_query.dart';

import 'custom_loading.dart';

class CustomButton extends StatelessWidget {
  final Widget? child;
  final void Function() onPressed;
  final double? height, width, strokeWidth, fontSize, imageW, imageH;
  final Color? backgroundColor;
  final BorderSide? borderSide;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final String? text, image, fontFamily;
  final TextStyle? style;
  final bool? isLoading, isStoreButton, isHasShadow, isHasImage, isLang;

  const CustomButton({
    super.key,
    this.child,
    this.text,
    this.image,
    this.style,
    this.fontFamily,
    this.fontSize,
    required this.onPressed,
    this.height,
    this.width,
    this.imageH,
    this.imageW,
    this.backgroundColor,
    this.isLoading = false,
    this.isStoreButton = false,
    this.isHasShadow = false,
    this.isHasImage = false,
    this.isLang = false,
    this.borderSide,
    this.borderRadius,
    this.padding,
    this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? context.height * 0.058,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.primaryColor,
        borderRadius: borderRadius ?? BorderRadius.circular(16.r),
        boxShadow: isHasShadow == true
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha:  0.15),
                  blurRadius: 6.0,
                  spreadRadius: 2.0,
                  offset: const Offset(0, 3),
                ),
              ]
            : [],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
              backgroundColor ?? AppColors.primaryColor),
          elevation: const WidgetStatePropertyAll(0),
          padding: WidgetStatePropertyAll(padding ?? EdgeInsets.zero),
          fixedSize: WidgetStatePropertyAll(
            Size(width ?? double.infinity, height ?? context.height * 0.058),
          ),
          minimumSize: WidgetStatePropertyAll(
            Size(width ?? double.infinity, height ?? context.height * 0.058),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(16.r),
            ),
          ),
          side: WidgetStatePropertyAll(borderSide ?? BorderSide.none),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isHasImage == true && isLang == false) ...[
                SvgPicture.asset(
                  image!,
                  height: imageH ?? 24.h,
                  width: imageW ?? 24.w,
                ),
                widthSpace(8.w),
              ],

              Flexible(
                child: child ??
                    Text(
                      text!,
                      textAlign: TextAlign.center,
                      style: style ??
                          AppTextStyles.textStyle16.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.whiteColor,
                            fontSize: fontSize ?? AppFonts.t16,
                            fontFamily: fontFamily ?? AppConstants.fontFamily,
                          ),
                    ),
              ),

              if (isLoading == true) ...[
                widthSpace(7.w),
                CustomLoading(
                  isButton: true,
                  isStoreButton: isStoreButton,
                  strokeWidth: strokeWidth ?? 3.5.w,
                ),
              ],

              if (isHasImage == true && isLang == true) ...[
                widthSpace(8.w),
                SvgPicture.asset(
                  image!,
                  height: imageH ?? 24.h,
                  width: imageW ?? 24.w,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

