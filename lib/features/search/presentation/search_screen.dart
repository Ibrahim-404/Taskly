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
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 100,
            collapsedHeight: 90,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: MediaQuery.of(context).padding.top + 8,
                  bottom: 8,
                ),
                child: CustomSearch(
                  searchController: _searchController,
                  onChanged: (value) => _taskController.setSearchQuery(value),
                  enabled: true,
                ),
              ),
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Obx(() {
                final count = _taskController.displayedTasks.length;
                return Text(
                  count == 1 ? '1 task found' : '$count tasks found',
                  style: TextStyle(
                    fontSize: 13,
                    color: cs.onSurfaceVariant,
                  ),
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
                  childCount: 6,
                ),
              );
            }
            if (tasks.isEmpty) {
              return SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: cs.surfaceContainerHighest.withValues(alpha: 0.5),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.search_off_rounded,
                          size: 36,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _taskController.searchQuery.value != null
                            ? 'No tasks match your search'
                            : 'No tasks found',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: cs.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Try adjusting your search or filter',
                        style: TextStyle(
                          fontSize: 14,
                          color: cs.onSurfaceVariant,
                        ),
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
