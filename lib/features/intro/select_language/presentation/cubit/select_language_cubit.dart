import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:easacc_task/core/constants/app_cached.dart';
import 'package:easacc_task/core/local/shared_preferences/shared_pref_services.dart';
import 'package:easacc_task/core/util/extensions/navigation.dart';
import 'package:easacc_task/core/util/routing/routes.dart';

part 'select_language_state.dart';

@injectable
class SelectLanguageCubit extends Cubit<SelectLanguageState> {
  final SharedPrefServices appPref;

  SelectLanguageCubit(this.appPref) : super(SelectLanguageInitial());

  void saveChanges(BuildContext context, int index) {
    if (index == 0) {
      context.setLocale(const Locale('ar'));
      appPref.saveData(AppCached.lang, 'ar');
      context.pushWithNamed(Routes.loginView);
    } else {
      context.setLocale(const Locale('en'));
      appPref.saveData(AppCached.lang, 'en');
      context.pushWithNamed(Routes.loginView);
    }
  }
}
