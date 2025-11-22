import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easacc_task/core/constants/app_assets.dart';
import 'package:easacc_task/core/constants/app_colors.dart';
import 'package:easacc_task/core/constants/app_text_styles.dart';
import 'package:easacc_task/core/framework/spaces.dart';
import 'package:easacc_task/core/util/extensions/media_query.dart';
import 'package:easacc_task/generated/locale_keys.g.dart';

class CustomLoading extends StatelessWidget {
  final bool? isButton, isLogo, isStoreButton;
  final double? heightLoading, widthLoading, strokeWidth;

  const CustomLoading({
    super.key,
    this.isButton = false,
    this.isLogo = true,
    this.isStoreButton = false,
    this.heightLoading,
    this.widthLoading,
    this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    return isButton == true
        ? SizedBox(
            height: heightLoading ?? 20.h,
            width: widthLoading ?? 20.w,
            child: CircularProgressIndicator(
              color: isStoreButton == true
                  ? AppColors.primaryColor
                  : AppColors.whiteColor,
              strokeWidth: strokeWidth ?? 4.w,
            ),
          )
        : SizedBox(
            width: context.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppAssets.loading, width: context.width / 3.3,color: AppColors.primaryColor,),
                heightSpace(16.h),
                Text(
                  LocaleKeys.loading.tr(),
                  style: AppTextStyles.textStyle16.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
  }
}
