import 'package:easacc_task/core/local/shared_preferences/shared_pref_services.dart';
import 'package:easacc_task/core/util/extensions/navigation.dart';
import 'package:easacc_task/core/util/routing/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'splash_state.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  final SharedPrefServices appPref;

  SplashCubit(this.appPref) : super(SplashInitial());

  void handlePageNext(BuildContext context) {
    Future.delayed(const Duration(seconds: 6), () async {
      // final token = appPref.getData(key: AppCached.token) ?? "";

      context.pushAndRemoveUntilWithNamed(Routes.selectLanguageView);

      // if (token.isNotEmpty) {
      //   if (context.mounted) {
      //     context.pushAndRemoveUntilWithNamed(
      //       Routes.home,
      //     );
      //   }
      // } else {
      //   if (context.mounted) {
      //     context.pushAndRemoveUntilWithNamed(
      //       Routes.selectLanguageView,
      //     );
      //   }
      // }
    });
  }
}
