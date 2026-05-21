import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/di/services_locator.dart';
import 'package:tourismapp/core/routes/app_routes.dart';
import 'package:tourismapp/core/localization/cubit/locale_cubit.dart';
import 'package:tourismapp/core/localization/cubit/locale_state.dart';
import 'package:tourismapp/l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => sl<LocaleCubit>(),
          child: BlocBuilder<LocaleCubit, LocaleState>(
            builder: (context, state) {
              return MaterialApp.router(
                title: 'Tourism App',
                routerConfig: createRouter(),
                debugShowCheckedModeBanner: false,
                locale: state.locale,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en'),
                  Locale('ar'),
                  Locale('fr'),
                ],
                builder: EasyLoading.init(),
              );
            },
          ),
        );
      },
    );
  }
}
