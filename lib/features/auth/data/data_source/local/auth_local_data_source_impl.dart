// import 'package:injectable/injectable.dart';
// import 'package:mokawlat_app/core/constants/app_cached.dart';
// import 'package:mokawlat_app/core/errors/exceptions.dart';
// import 'package:mokawlat_app/core/local/shared_preferences/shared_pref_services.dart';
// import 'package:mokawlat_app/features/common/auth/data/data_source/local/auth_local_data_source.dart';
// import 'package:mokawlat_app/features/common/auth/data/models/user_data_response_model.dart';

// @Injectable(as: AuthLocalDataSource)
// class AuthLocalDataSourceImpl extends AuthLocalDataSource {
//   final SharedPrefServices appPref;

//   AuthLocalDataSourceImpl({
//     required this.appPref,
//   });

//   @override
//   Future<void> saveDataUser({
//     required UserDataResponseModel user,
//   }) async {
//     try {
//       await appPref.saveData(AppCached.token, user.token);
//       await appPref.saveData(AppCached.userType, user.user!.userType);
//       await appPref.saveData(AppCached.userImage, user.user!.img);
//       await appPref.saveData(AppCached.email, user.user!.email);
//       await appPref.saveData(AppCached.userName, user.user!.name);
//       await appPref.saveData(AppCached.phone, user.user!.phone);
//     } catch (error) {
//       throw CacheSaveException();
//     }
//   }
// }
