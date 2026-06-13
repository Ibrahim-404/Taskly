import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tasks_manager/features/tasks/domain/entities/task_entity.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_controller.dart';
import 'package:tasks_manager/features/search/presentation/search_screen.dart' as search_screen;
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
    // Fetch tasks on initial load. The controller should internally check 
    // if data already exists to avoid redundant network/database requests.
    taskController.fetchTasks(); 
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      // Wrapped in RefreshIndicator to pull-to-refresh and trigger new data updates manually
      child: RefreshIndicator(
        onRefresh: () async {
          // Force refresh to pull fresh data from the data source
          await taskController.fetchTasks(forceRefresh: true);
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const search_screen.SearchScreen(),
                        ),
                      );
                    },
                    child: IgnorePointer(
                      child: CustomSearch(
                        searchController: TextEditingController(),
                        enabled: false,
                      ),
                    ),
                  ),
                  TaskComposition(onlyForSearch: true),
                ],
              ),
            ),
            
            Obx(() {
              return Skeletonizer.sliver(
                enabled: taskController.isTasksLoading.value,
                child: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final task = taskController.isTasksLoading.value
                          ? TaskEntity.skeleton()
                          : taskController.tasks[index];
                      return TaskRepresenter(task: task, onlyRepresenter: true);
                    },
                    childCount: taskController.isTasksLoading.value
                        ? 10
                        : taskController.tasks.length,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}