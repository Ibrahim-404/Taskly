import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/features/Tasks/presenter/ui/task_main_screen.dart';

import 'Core/injection_container.dart';

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
      theme: ThemeData(useMaterial3: true),
      darkTheme: ThemeData.dark(),
      home: const TaskMainScreen(),
      initialBinding: InjectionContainer(),
    );
  }
}
