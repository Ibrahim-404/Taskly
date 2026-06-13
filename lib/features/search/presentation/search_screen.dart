import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/features/tasks/domain/entities/task_entity.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_controller.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/custom_search.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/task_representer.dart';
import 'package:tasks_manager/features/search/presentation/widgets/filter_chips.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TaskController _taskController = Get.find();
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            title: CustomSearch(
              searchController: _searchController,
              onChanged: (value) => _taskController.setSearchQuery(value),
              enabled: true,
            ),
          ),
          SliverToBoxAdapter(
            child: Obx(() => FilterChips(
              activeFilter: _taskController.activeFilter.value,
              onFilterChanged: (filter) => _taskController.setFilter(filter),
            )),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Obx(() {
                final count = _taskController.displayedTasks.length;
                return Text(
                  count == 1 ? '1 task found' : '$count tasks found',
                  style: Theme.of(context).textTheme.bodySmall,
                );
              }),
            ),
          ),
          Obx(() {
            final tasks = _taskController.displayedTasks;
            if (_taskController.isTasksLoading.value) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => TaskRepresenter(
                    task: TaskEntity.skeleton(),
                    onlyRepresenter: true,
                  ),
                  childCount: 10,
                ),
              );
            }
            if (tasks.isEmpty) {
              return SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        _taskController.searchQuery.value != null
                            ? 'No tasks match your search'
                            : 'No tasks found',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              );
            }
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => TaskRepresenter(
                  task: tasks[index],
                  onlyRepresenter: true,
                ),
                childCount: tasks.length,
              ),
            );
          }),
        ],
      ),
    );
  }
}
