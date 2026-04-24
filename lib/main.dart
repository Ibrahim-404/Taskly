import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tasks_manager/main_screen.dart';

import 'core/injection_container.dart';
import 'core/const/strings.dart';

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
      title: Strings.taskly,
      theme: ThemeData(useMaterial3: true),
      darkTheme: ThemeData.dark(),
      home: MainScreen(),
      initialBinding: InjectionContainer(),
    );
  }
}
