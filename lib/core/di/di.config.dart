// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:easacc_task/core/api/api_consumer.dart' as _i243;
import 'package:easacc_task/core/api/dio_consumer.dart' as _i848;
import 'package:easacc_task/core/api/dio_log_interceptor.dart' as _i424;
import 'package:easacc_task/core/api/network_info.dart' as _i553;
import 'package:easacc_task/core/di/di_module.dart' as _i847;
import 'package:easacc_task/core/local/shared_preferences/shared_pref_services.dart'
    as _i722;
import 'package:easacc_task/features/auth/data/data_source/remote/auth_remote_data_source.dart'
    as _i686;
import 'package:easacc_task/features/auth/data/data_source/remote/auth_remote_data_source_impl.dart'
    as _i6;
import 'package:easacc_task/features/auth/data/repository/auth_repository.dart'
    as _i290;
import 'package:easacc_task/features/auth/data/repository/auth_repository_impl.dart'
    as _i1034;
import 'package:easacc_task/features/auth/login/presentation/cubit/login_cubit.dart'
    as _i1028;
import 'package:easacc_task/features/intro/select_language/presentation/cubit/select_language_cubit.dart'
    as _i677;
import 'package:easacc_task/features/intro/splash/presentation/cubit/splash_cubit.dart'
    as _i325;
import 'package:easacc_task/features/setting/data/data_source/remote/setting_remote_data_source.dart'
    as _i1031;
import 'package:easacc_task/features/setting/data/data_source/remote/setting_remote_data_source_impl.dart'
    as _i93;
import 'package:easacc_task/features/setting/data/repository/setting_repository.dart'
    as _i1051;
import 'package:easacc_task/features/setting/data/repository/setting_repository_impl.dart'
    as _i157;
import 'package:easacc_task/features/setting/presentation/cubit/setting_cubit.dart'
    as _i620;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final injectionModule = _$InjectionModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => injectionModule.prefs,
      preResolve: true,
    );
    gh.factory<_i161.InternetConnection>(
      () => injectionModule.internetConnection,
    );
    gh.factory<_i361.Dio>(() => injectionModule.dioClient);
    gh.lazySingleton<_i424.DioLogInterceptor>(() => _i424.DioLogInterceptor());
    gh.factory<_i686.AuthRemoteDataSource>(
      () => _i6.AuthRemoteDataSourceImpl(),
    );
    gh.factory<_i1031.SettingRemoteDataSource>(
      () => _i93.SettingRemoteDataSourceImpl(),
    );
    gh.factory<_i290.AuthRepository>(
      () => _i1034.AuthRepositoryImpl(
        authRemoteDataSource: gh<_i686.AuthRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i722.SharedPrefServices>(
      () => _i722.SharedPrefServices(
        sharedPreferences: gh<_i460.SharedPreferences>(),
      ),
    );
    gh.factory<_i1051.SettingRepository>(
      () => _i157.SettingRepositoryImpl(
        settingRemoteDataSource: gh<_i1031.SettingRemoteDataSource>(),
      ),
    );
    gh.factory<_i553.NetworkInfo>(
      () => _i553.NetworkInfoImpl(
        internetConnection: gh<_i161.InternetConnection>(),
      ),
    );
    gh.factory<_i677.SelectLanguageCubit>(
      () => _i677.SelectLanguageCubit(gh<_i722.SharedPrefServices>()),
    );
    gh.factory<_i325.SplashCubit>(
      () => _i325.SplashCubit(gh<_i722.SharedPrefServices>()),
    );
    gh.factory<_i620.SettingCubit>(
      () => _i620.SettingCubit(gh<_i722.SharedPrefServices>()),
    );
    gh.lazySingleton<_i243.ApiConsumer>(
      () => _i848.DioApiConsumer(
        networkInfo: gh<_i553.NetworkInfo>(),
        dioClient: gh<_i361.Dio>(),
        appPref: gh<_i722.SharedPrefServices>(),
      ),
    );
    gh.factory<_i1028.LoginCubit>(
      () => _i1028.LoginCubit(gh<_i290.AuthRepository>()),
    );
    return this;
  }
}

class _$InjectionModule extends _i847.InjectionModule {}
