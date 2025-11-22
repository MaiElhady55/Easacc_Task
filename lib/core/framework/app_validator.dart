import 'package:easacc_task/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class AppValidator {
  

  static urlValidator() {
    return (value) {
      if (value == null || value.isEmpty) {
        return LocaleKeys.enterValidURL.tr();
      }
      final urlPattern = r'^(https?:\/\/)?([\w\-]+(\.[\w\-]+)+)([\w.,@?^=%&:/~+#\-]*[\w@?^=%&/~+#\-])?$';
      final regExp = RegExp(urlPattern);

      if (!regExp.hasMatch(value)) {
        return LocaleKeys.enterValidURL.tr();
      }

      return null; 
    };
  }


  // static dropDownSuggestionValidator() {
  //   return (value) {
  //     if (value == null || value.isEmpty) {
  //       return LocaleKeys.emptySuggestion.tr();
  //     }
  //     return null;
  //   };
  // }

  
}
