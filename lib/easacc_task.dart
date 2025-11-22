import 'package:easacc_task/core/constants/app_colors.dart';
import 'package:easacc_task/core/constants/app_constants.dart';
import 'package:easacc_task/core/util/routing/app_router.dart';
import 'package:easacc_task/core/util/routing/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class EasaccTask extends StatefulWidget {
  final AppRouter appRouter;

  const EasaccTask({super.key, required this.appRouter});

  static GlobalKey<NavigatorState> appNavigatorKey =
      GlobalKey<NavigatorState>();

  @override
  State<EasaccTask> createState() => _EasaccTaskState();
}

class _EasaccTaskState extends State<EasaccTask> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      designSize: const Size(430, 932),
      child: MaterialApp(
        title: AppConstants.appName,
        navigatorKey: EasaccTask.appNavigatorKey,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        onGenerateRoute: widget.appRouter.generateRoute,
        initialRoute: Routes.splashView,
        theme: ThemeData(
          fontFamily: AppConstants.fontFamily,
          scaffoldBackgroundColor: AppColors.whiteColor,
          brightness: Brightness.light,
        ),
      ),
    );
  }
}
