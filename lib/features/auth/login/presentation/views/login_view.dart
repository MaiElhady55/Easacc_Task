import 'package:easacc_task/core/widgets/custom_toast.dart';
import 'package:easacc_task/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easacc_task/core/constants/app_assets.dart';
import 'package:easacc_task/core/constants/app_colors.dart';
import 'package:easacc_task/core/constants/app_text_styles.dart';
import 'package:easacc_task/core/framework/spaces.dart';
import 'package:easacc_task/core/util/extensions/media_query.dart';
import 'package:easacc_task/core/util/extensions/navigation.dart';
import 'package:easacc_task/core/util/routing/routes.dart';
import 'package:easacc_task/core/widgets/custom_button.dart';
import 'package:easacc_task/generated/locale_keys.g.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is GoogleLoginSuccess || state is FacebookLoginSuccess) {
              final message = state is GoogleLoginSuccess
                  ? state.message
                  : (state as FacebookLoginSuccess).message;
              showToast(text: message, state: ToastStates.success);
              context.pushAndRemoveUntilWithNamed(Routes.settingView);
            }
            if (state is GoogleLoginFailure || state is FacebookLoginFailure) {
              final error = state is GoogleLoginFailure
                  ? state.error
                  : (state as FacebookLoginFailure).error;
              showToast(text: error, state: ToastStates.error);
            }
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                heightSpace(context.height * 0.050),
                SizedBox(
                  width: context.width * 0.18,
                  height: context.height * 0.065,
                  child: SvgPicture.asset(AppAssets.logo),
                ),
                heightSpace(context.height * 0.03),
                Text(
                  LocaleKeys.welcomeBack.tr(),
                  style: AppTextStyles.textStyle28.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                heightSpace(10.h),
                Text(
                  LocaleKeys.loginDesc.tr(),
                  style: AppTextStyles.textStyle18.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.greyColor,
                  ),
                ),
                heightSpace(context.height * 0.15),
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    final cubit = BlocProvider.of<LoginCubit>(context);
                    return Column(
                      children: [
                        CustomButton(
                          onPressed: () {
                            cubit.loginWithGoogle();
                          },

                          isLoading: state is GoogleLoginLoading,
                          text: LocaleKeys.loginWithGoogle.tr(),
                          isHasImage: true,
                          image: AppAssets.google,
                        ),
                        heightSpace(24.h),
                        CustomButton(
                          onPressed: () {
                            cubit.loginWithFacebook();
                          },
                          isLoading: state is FacebookLoginLoading,
                          borderSide: const BorderSide(
                            color: AppColors.primaryColor,
                          ),
                          text: LocaleKeys.loginWithFacebook.tr(),
                          isStoreButton: true,
                          backgroundColor: AppColors.whiteColor,
                          style: AppTextStyles.textStyle16.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryColor,
                          ),
                          isHasImage: true,
                          image: AppAssets.facebook,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
