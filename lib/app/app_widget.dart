import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:perfect_numbers/app/core/di/injection_container.dart';
import 'package:perfect_numbers/app/core/routes/app_router.dart';
import 'package:perfect_numbers/app/core/theme/dark_theme.dart';
import 'package:perfect_numbers/app/core/theme/light_theme.dart';
import 'package:perfect_numbers/app/features/perfect_number/data/datasources/history_local_data_source.dart';
import 'package:perfect_numbers/app/features/perfect_number/presentation/cubits/settings/settings_cubit.dart';
import 'package:perfect_numbers/app/features/perfect_number/presentation/cubits/settings/settings_state.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsCubit>.value(
      value: sl<SettingsCubit>(),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, settings) {
          final onboardingSeen =
              GetIt.I<HistoryLocalDataSource>().onboardingSeen;
          return MaterialApp(
            title: 'Números Perfeitos',
            debugShowCheckedModeBanner: false,
            theme: LightTheme.theme,
            darkTheme: DarkTheme.theme,
            themeMode: settings.themeMode,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('pt', 'BR'), Locale('en', 'US')],
            initialRoute: onboardingSeen ? Routes.main : Routes.onboarding,
            onGenerateRoute: Routes.onGenerateRoute,
            locale:
                settings.language == 'English'
                    ? const Locale('en', 'US')
                    : const Locale('pt', 'BR'),
            builder: (context, child) {
              final mq = MediaQuery.of(context);
              return MediaQuery(
                data: mq.copyWith(
                  textScaler: mq.textScaler.clamp(
                    minScaleFactor: 0.85,
                    maxScaleFactor: 1.2,
                  ),
                ),
                child: child ?? const SizedBox.shrink(),
              );
            },
          );
        },
      ),
    );
  }
}
