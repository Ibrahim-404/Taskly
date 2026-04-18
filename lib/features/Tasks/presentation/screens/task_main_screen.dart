// import 'package:flutter/material.dart';
// import 'package:tasks_manager/features/tasks/presentation/widgets/custom_show_dialog_for_add_new_Task.dart';
// import 'package:tasks_manager/features/tasks/presentation/widgets/task_composition.dart';

// class TaskMainScreen extends StatefulWidget {
//   const TaskMainScreen({super.key});

//   @override
//   State<TaskMainScreen> createState() => _TaskMainScreenState();
// }

// class _TaskMainScreenState extends State<TaskMainScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => CustomShowDialogForAddNewTask(),
//             ),
//           );
//         },
//         child: const Icon(Icons.add),
//       ),
//       body: TaskComposition(),
//     );
//   }
// }
