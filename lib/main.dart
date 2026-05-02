import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tasks_manager/features/tasks/presentation/screens/main_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tasks_manager/l10n/app_localizations.dart';

import 'core/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await init();
  runApp(const Taskly());
}

class Taskly extends StatelessWidget {
  const Taskly({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taskly',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      theme: ThemeData(useMaterial3: true),
      darkTheme: ThemeData.dark(),
      home: MainScreen(),
      initialBinding: InjectionContainer(),
    );
  }
}
