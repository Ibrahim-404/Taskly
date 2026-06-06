import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_controller.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/custom_search.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/task_composition.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/task_representer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TaskController taskController = Get.find();

  @override
  void initState() {
    super.initState();
    ever(taskController.selectedCategory, (String? val) {
      if (val == null) return;
      if (val == 'All') {
        taskController.fetchTasks();
      } else {
        taskController.fetchTasksByCategory(val);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              child: CustomSearch(searchController: TextEditingController()),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const SearchScreen(),
                  ),
                );
              },
            ),
            TaskComposition(onlyForSearch: true),
            Obx(() {
              if (taskController.isTasksLoading.value) {
                return const Center(child: CupertinoActivityIndicator());
              }

              final list = taskController.tasks;
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final task = list[index];
                  return TaskRepresenter(task: task);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
