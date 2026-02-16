import 'package:flutter/material.dart';
import 'package:tasks_manager/features/Core/injection_container.dart';
import 'package:tasks_manager/features/Tasks/presenter/ui/task_main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const Taskly());
}

class Taskly extends StatelessWidget {
  const Taskly({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taskly',
      theme: ThemeData(useMaterial3: true),
      darkTheme: ThemeData.dark(),
      home: const TaskMainScreen(),
    );
  }
}
