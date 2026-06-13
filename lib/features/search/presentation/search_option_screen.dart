import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tasks_manager/features/tasks/domain/entities/task_entity.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_controller.dart';
import 'package:tasks_manager/features/search/presentation/search_screen.dart'
    as search_screen;
import 'package:tasks_manager/features/tasks/presentation/widgets/custom_search.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/task_composition.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/task_representer.dart';

class SearchOptionScreen extends StatefulWidget {
  const SearchOptionScreen({super.key});

  @override
  State<SearchOptionScreen> createState() => _SearchOptionScreenState();
}

class _SearchOptionScreenState extends State<SearchOptionScreen> {
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
              behavior: HitTestBehavior.opaque,
              child: IgnorePointer(
                child: CustomSearch(
                  searchController: TextEditingController(),
                  enabled: false,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const search_screen.SearchScreen(),
                  ),
                );
              },
            ),
            TaskComposition(onlyForSearch: true),
            Obx(() {
              // if (taskController.isTasksLoading.value) {
              //   return const Center(child: CupertinoActivityIndicator());
              // }

              return Skeletonizer(
                enabled: taskController.isTasksLoading.value,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: taskController.isTasksLoading.value
                      ? 10
                      : taskController.tasks.length,
                  itemBuilder: (context, index) {
                    final task = taskController.isTasksLoading.value
                        ? TaskEntity.skeleton()
                        : taskController.tasks[index];
                    return TaskRepresenter(task: task, onlyRepresenter: true);
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
