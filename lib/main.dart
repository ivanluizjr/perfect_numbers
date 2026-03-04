import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:perfect_numbers/app/app_widget.dart';
import 'package:perfect_numbers/app/core/di/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );

  await di.initDependencies();

  runApp(const AppWidget());
}
