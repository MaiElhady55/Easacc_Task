import 'package:easacc_task/core/constants/app_assets.dart';
import 'package:easacc_task/core/constants/app_colors.dart';
import 'package:easacc_task/core/constants/app_text_styles.dart';
import 'package:easacc_task/core/framework/app_validator.dart';
import 'package:easacc_task/core/framework/spaces.dart';
import 'package:easacc_task/core/util/extensions/media_query.dart';
import 'package:easacc_task/core/widgets/custom_button.dart';
import 'package:easacc_task/core/widgets/custom_text_form_field.dart';
import 'package:easacc_task/core/widgets/custom_toast.dart';
import 'package:easacc_task/features/setting/presentation/cubit/setting_cubit.dart';
import 'package:easacc_task/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.setting.tr(),
          style: AppTextStyles.textStyle20.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.whiteColor,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
      ),

      body: BlocConsumer<SettingCubit, SettingState>(
        listener: (context, state) {
          if (state is SettingUrlSaved) {
            showToast(
              text: LocaleKeys.urlSavedSuccessfully.tr(),
              state: ToastStates.success,
            );
          }

          if (state is SettingError) {
            showToast(text: state.error, state: ToastStates.error);
          }
        },
        builder: (context, state) {
          final cubit = context.read<SettingCubit>();
          return Form(
            key: cubit.formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 25.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.websiteURL.tr(),
                    style: AppTextStyles.textStyle16.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.blackColor,
                    ),
                  ),
                  heightSpace(16.h),
                  CustomTextFormField(
                    ctrl: cubit.urlCtrl,
                    keyboardType: TextInputType.text,
                    hintText: "https:/example.com",
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: AppValidator.urlValidator(),
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                  ),
                  heightSpace(30.h),
                  CustomButton(
                    onPressed: () {
                      bool? isFormValidated = cubit.formKey.currentState
                          ?.validate();

                      if (isFormValidated!) {
                        cubit.saveWebsiteURL();
                      } else {
                        debugPrint("Not Valid");
                        return;
                      }
                    },
                    isLoading: state is SettingLoading,
                    text: LocaleKeys.save.tr(),
                  ),
                  heightSpace(20.h),
                  CustomButton(
                    onPressed: () {
                      if (cubit.formKey.currentState!.validate()) {
                        cubit.openWebsite(context);
                      }
                    },
                    text: LocaleKeys.openWebsite.tr(),
                    borderSide: const BorderSide(color: AppColors.primaryColor),
                    isStoreButton: true,
                    backgroundColor: AppColors.whiteColor,
                    style: AppTextStyles.textStyle16.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  heightSpace(50.h),
                  Text(
                    LocaleKeys.scanPrinters.tr(),
                    style: AppTextStyles.textStyle16.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.blackColor,
                    ),
                  ),
                  heightSpace(16.h),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          onPressed: () {
                            cubit.scanPrinters();
                          },
                          text: LocaleKeys.bluetooth.tr(),
                        ),
                      ),
                      widthSpace(16.w),
                      Expanded(
                        child: CustomButton(
                          onPressed: () {},
                          text: LocaleKeys.wifi.tr(),
                        ),
                      ),
                    ],
                  ),
                  heightSpace(30.h),
                  
                  if (cubit.devices.isNotEmpty) ...[
                    
                    Text(
                      LocaleKeys.avaliblePrinters.tr(),
                      style: AppTextStyles.textStyle16.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColor,
                      ),
                    ),
                    heightSpace(16.h),

                    if (state is PrinterScanning)
                      Center(
                        child: Image.asset(AppAssets.loading, height: context.height*0.1),
                      ),
                    if (cubit.devices.isNotEmpty)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: DropdownButton<BluetoothInfo>(
                          hint: Text(LocaleKeys.selectPrinter.tr()),
                          isExpanded: true,
                          value: cubit.devices.isEmpty
                              ? null
                              : cubit.devices.firstWhere(
                                  (d) => d.macAdress == cubit.selectedMac,
                                  orElse: () => cubit.devices.first,
                                ),
                          underline: const SizedBox(),
                          items: cubit.devices.map((device) {
                            return DropdownMenuItem<BluetoothInfo>(
                              value: device,
                              child: Text(device.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              cubit.selectDevice(value);
                            }
                          },
                        ),
                      ),
                    if (state is PrinterError)
                      Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),

                    heightSpace(30.h),

                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            onPressed: () {
                              if (cubit.selectedMac != null) {
                                cubit.connectPrinter(
                                  cubit.selectedMac!,
                                  name: cubit.selectedName,
                                );
                              } else {
                                showToast(
                                  text: LocaleKeys.pleaseSelectPrinter.tr(),
                                  state: ToastStates.warning,
                                );
                              }
                            },
                            isLoading: state is PrinterConnecting,
                            text: LocaleKeys.connect.tr(),
                          ),
                        ),
                        widthSpace(16.w),
                        Expanded(
                          child: CustomButton(
                            onPressed: () {
                              if (cubit.selectedMac != null) {
                                cubit.printReceipt();
                              } else {
                                showToast(
                                  text: LocaleKeys.pleaseSelectPrinter.tr(),
                                  state: ToastStates.warning,
                                );
                              }
                            },
                            isLoading: state is PrinterPrinting,
                            text: LocaleKeys.testPrint.tr(),
                            borderSide: const BorderSide(
                              color: AppColors.primaryColor,
                            ),
                            isStoreButton: true,
                            backgroundColor: AppColors.whiteColor,
                            style: AppTextStyles.textStyle16.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
