import 'package:easacc_task/core/constants/app_colors.dart';
import 'package:easacc_task/core/constants/app_assets.dart';
import 'package:easacc_task/core/constants/app_text_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easacc_task/core/framework/spaces.dart';
import 'package:easacc_task/core/util/extensions/media_query.dart';
import 'package:easacc_task/core/util/extensions/navigation.dart';
import 'package:easacc_task/core/util/extensions/on_tap.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? textAppBar;
  final double? heightAppBar;
  final bool? isHasText, isBack;
  final Widget? leadingIcon;
  final bool? isDividerImage;
  final TextStyle? textStyle;
  final void Function()? onTap;
  final BuildContext context;
  final Color? iconColor;
  final Color? textColor;

  const CustomAppBar({
    super.key,
    this.textAppBar,
    this.heightAppBar,
    this.isHasText = true,
    this.isBack = true,
    this.isDividerImage,
    this.textStyle,
    this.onTap,
    this.iconColor,
    this.leadingIcon,
    required this.context,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: 25.w,
            end: 25.w,
            top: 20.h,
            bottom: 5.h,
          ),
          child: Container(
            color: AppColors.blackColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (isBack == true) ...[
                      Container(
                        //padding:  EdgeInsets.symmetric(vertical: 8.h),
                        child: SvgPicture.asset(
                          context.locale.languageCode == "en"
                              ? AppAssets.arrowBackEn
                              : AppAssets.arrowBackAr,
                          color: iconColor ?? AppColors.whiteColor,
                          width:
                              context.locale.languageCode == "en" ? 18.w : 26.w,
                          height:
                              context.locale.languageCode == "en" ? 18.h : 26.h,
                        ).onTapShadow(
                          borderRadius: BorderRadius.circular(20.r),
                          function: onTap ??
                              () {
                                context.pop(true);
                              },
                        ),
                      ),
                    ],
                    if (isHasText == true) ...[
                      widthSpace(8.w),
                      Text(
                        textAppBar!,
                        style: textStyle ??
                            AppTextStyles.textStyle16.copyWith(
                                fontWeight: FontWeight.w400,
                                color: textColor ?? AppColors.whiteColor),
                      ),
                    ],
                  ],
                ),
                leadingIcon ?? const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size(double.infinity, heightAppBar ?? context.height * 0.55);
}
