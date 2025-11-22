import 'dart:io';
import 'package:easacc_task/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:easacc_task/features/auth/login/presentation/views/login_view.dart';
import 'package:easacc_task/features/intro/select_language/presentation/cubit/select_language_cubit.dart';
import 'package:easacc_task/features/intro/select_language/presentation/views/select_language_view.dart';
import 'package:easacc_task/features/intro/splash/presentation/cubit/splash_cubit.dart';
import 'package:easacc_task/features/intro/splash/presentation/views/splash_view.dart';
import 'package:easacc_task/features/setting/presentation/cubit/setting_cubit.dart';
import 'package:easacc_task/features/setting/presentation/views/setting_view.dart';
import 'package:easacc_task/features/setting/presentation/views/web_view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easacc_task/core/di/di.dart';
import 'package:easacc_task/core/framework/navigation_animation.dart';
import 'package:easacc_task/core/util/routing/routes.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case Routes.splashView:
        return _buildRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SplashCubit>(),
            child: const SplashView(),
          ),
        );

      case Routes.selectLanguageView:
        return _buildRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SelectLanguageCubit>(),
            child: const SelectLanguageView(),
          ),
        );
      case Routes.loginView:
        return _buildRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginView(),
          ),
        );

      case Routes.settingView:
        return _buildRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SettingCubit>(),
            child: const SettingView(),
          ),
        );
      case Routes.webView:
        final url = arguments as String;
        return _buildRoute(builder: (_) => WebViewPage(url: url));

      default:
        return _buildRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }

  PageRoute _buildRoute({required WidgetBuilder builder}) {
    return Platform.isAndroid
        ? FadePageRoute(builder: builder)
        : MaterialPageRoute(builder: builder);
  }
}
