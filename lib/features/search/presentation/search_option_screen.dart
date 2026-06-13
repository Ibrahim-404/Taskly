import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tasks_manager/features/tasks/domain/entities/task_entity.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_controller.dart';
import 'package:tasks_manager/features/search/presentation/search_screen.dart'
    as search_screen;
import 'package:tasks_manager/features/search/presentation/widgets/filter_chips.dart';
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
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    taskController.fetchTasks();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: RefreshIndicator(
        onRefresh: () async {
          await taskController.fetchTasks(forceRefresh: true);
        },
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 4),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const search_screen.SearchScreen(),
                        ),
                      );
                    },
                    child: AbsorbPointer(
                      child: CustomSearch(
                        searchController: _searchController,
                        enabled: false,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Obx(() => FilterChips(
                    activeFilter: taskController.activeFilter.value,
                    onFilterChanged: (filter) =>
                        taskController.setFilter(filter),
                  )),
                  TaskComposition(onlyForSearch: true),
                ],
              ),
            ),
            Obx(() {
              final displayed = taskController.isTasksLoading.value
                  ? <TaskEntity>[]
                  : taskController.displayedTasks;
              return Skeletonizer.sliver(
                enabled: taskController.isTasksLoading.value,
                child: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final task = taskController.isTasksLoading.value
                          ? TaskEntity.skeleton()
                          : displayed[index];
                      return TaskRepresenter(
                        task: task,
                        onlyRepresenter: true,
                      );
                    },
                    childCount: taskController.isTasksLoading.value
                        ? 6
                        : displayed.length,
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
