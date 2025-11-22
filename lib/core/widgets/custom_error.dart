import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easacc_task/core/constants/app_assets.dart';
import 'package:easacc_task/core/constants/app_text_styles.dart';
import 'package:easacc_task/core/framework/spaces.dart';
import 'package:easacc_task/core/util/extensions/media_query.dart';
import 'package:easacc_task/core/widgets/custom_button.dart';
import 'package:easacc_task/generated/locale_keys.g.dart';

class CustomError extends StatelessWidget {
  final String error;
  final void Function() retry;

  const CustomError(
      {super.key,
      required this.error,
      required this.retry,
      });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            error == LocaleKeys.noInternetError.tr()
                ? AppAssets.noInternet
                : AppAssets.defaultError,
            width: error == LocaleKeys.noInternetError.tr()
                ? context.width / 2.5
                : context.width / 3,
          ),
          heightSpace( error == LocaleKeys.noInternetError.tr()
                ?10.h:16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Text(
              error,
              style: AppTextStyles.textStyle14.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          heightSpace(20.h),
          CustomButton(
            onPressed: retry,
            text: LocaleKeys.retry.tr(),
            borderRadius: BorderRadius.circular(8.r),
            height: context.height * 0.05,
            width: context.width * 0.4,
          ),
        ],
      ),
    );
  }
}
