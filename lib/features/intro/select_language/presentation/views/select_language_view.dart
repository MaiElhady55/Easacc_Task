import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easacc_task/core/constants/app_assets.dart';
import 'package:easacc_task/core/constants/app_colors.dart';
import 'package:easacc_task/core/constants/app_text_styles.dart';
import 'package:easacc_task/core/framework/spaces.dart';
import 'package:easacc_task/core/util/extensions/media_query.dart';
import 'package:easacc_task/core/widgets/custom_button.dart';
import 'package:easacc_task/features/intro/select_language/presentation/cubit/select_language_cubit.dart';

class SelectLanguageView extends StatelessWidget {
  const SelectLanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 25.w,
            vertical: 20.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              heightSpace(context.height * 0.182),
              Text(
                'من فضلك حدد لغة التطبيق',
                textAlign: TextAlign.center,
                style: AppTextStyles.textStyle24.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              heightSpace(4.h),
              Text(
                'Please select language',
                textAlign: TextAlign.center,
                style: AppTextStyles.textStyle24.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              heightSpace(context.height * 0.11),
              CustomButton(
                onPressed: () {
                  context.read<SelectLanguageCubit>().saveChanges(context, 0);
                },
                text: "العربية",
                isLang: true,
                isHasImage: true,
                image: AppAssets.saudi,
              ),
              heightSpace(24.h),
              CustomButton(
                onPressed: () {
                  context.read<SelectLanguageCubit>().saveChanges(context, 1);
                },
                text: "English",
                isLang: true,
                isHasImage: true,
                image: AppAssets.united,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
