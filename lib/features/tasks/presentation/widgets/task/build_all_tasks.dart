import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:tasks_manager/features/tasks/domain/entities/task_entity.dart';
import 'package:tasks_manager/features/tasks/presentation/controllers/task_controller.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/task_composition.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/task_representer.dart';

class BuildAllTasks extends StatefulWidget {
  const BuildAllTasks({super.key});

  @override
  State<BuildAllTasks> createState() => _BuildAllTasksState();
}

class _BuildAllTasksState extends State<BuildAllTasks> {
  late final ItemScrollController _itemScrollController;
  late final ItemPositionsListener _itemPositionsListener;
  Worker? _scrollWorker;
  Worker? _loadingWorker;

  @override
  void initState() {
    super.initState();
    _itemScrollController = ItemScrollController();
    _itemPositionsListener = ItemPositionsListener.create();

    final taskController = Get.find<TaskController>();

    _scrollWorker = ever(taskController.rxScrollToTaskId, (String? taskId) {
      if (taskId != null) _attemptScroll(taskId);
    });

    _loadingWorker = ever(taskController.isTasksLoading, (bool isLoading) {
      final taskId = taskController.rxScrollToTaskId.value;
      if (!isLoading && taskId != null) _attemptScroll(taskId);
    });
  }

  @override
  void dispose() {
    _scrollWorker?.dispose();
    _loadingWorker?.dispose();
    super.dispose();
  }

  void _attemptScroll(String taskId) async {
    final taskController = Get.find<TaskController>();
    if (taskController.isTasksLoading.value) return;

    final index = taskController.upcomingTasks.indexWhere(
      (task) => task.id.toString() == taskId,
    );

    if (index != -1) {
      await Future.delayed(const Duration(milliseconds: 300));
      if (_itemScrollController.isAttached) {
        _itemScrollController.scrollTo(
          index: index,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
        taskController.rxScrollToTaskId.value = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TaskController>();
    final cs = Theme.of(context).colorScheme;

    return Obx(() {
      if (controller.taskErrorMessage.value.isNotEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline_rounded, size: 48, color: cs.error),
                const SizedBox(height: 16),
                Text(
                  controller.taskErrorMessage.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: cs.onSurfaceVariant),
                ),
              ],
            ),
          ),
        );
      }

      final showEmpty =
          !controller.isTasksLoading.value && controller.upcomingTasks.isEmpty;
      if (showEmpty) {
        return Center(
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
                  Icons.task_alt_rounded,
                  size: 36,
                  color: cs.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'No tasks yet',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tap + to create your first task',
                style: TextStyle(
                  fontSize: 14,
                  color: cs.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
              TaskComposition(onlyForSearch: false),
            ],
          ),
        );
      }

      return Column(
        children: [
          TaskComposition(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => controller.fetchTasks(forceRefresh: true),
              child: Skeletonizer(
                enabled: controller.isTasksLoading.value,
                child: ScrollablePositionedList.builder(
                  itemScrollController: _itemScrollController,
                  itemPositionsListener: _itemPositionsListener,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.isTasksLoading.value
                      ? 5
                      : controller.upcomingTasks.length,
                  itemBuilder: (context, index) {
                    final task = controller.isTasksLoading.value
                        ? TaskEntity.skeleton()
                        : controller.upcomingTasks[index];
                    return TaskRepresenter(
                      key: ValueKey(task.id),
                      task: task,
                      onlyRepresenter: false,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
