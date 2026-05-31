import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tasks_manager/core/const/app_colors.dart';
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
      if (taskId != null) {
        _attemptScroll(taskId);
      }
    });

    _loadingWorker = ever(taskController.isTasksLoading, (bool isLoading) {
      final taskId = taskController.rxScrollToTaskId.value;
      if (!isLoading && taskId != null) {
        _attemptScroll(taskId);
      }
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
    
    if (taskController.isTasksLoading.value) {
      return;
    }

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
    final TaskController controller = Get.find<TaskController>();

    return Obx(() {
      if (controller.taskErrorMessage.value.isNotEmpty) {
        return Center(child: Text(controller.taskErrorMessage.value));
      }

      final showEmpty = !controller.isTasksLoading.value && controller.upcomingTasks.isEmpty;
      if (showEmpty) {
        return const Center(
          child: Text(
            'No tasks available',
            style: TextStyle(fontSize: 16, color: AppColors.grey),
          ),
        );
      }

      return Column(
        children: [
          TaskComposition(),
          Expanded(
            child: Skeletonizer(
              enabled: controller.isTasksLoading.value,
              child: ScrollablePositionedList.builder(
                itemScrollController: _itemScrollController,
                itemPositionsListener: _itemPositionsListener,
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
                  );
                },
              ),
            ),
          ),
        ],
      );
    });
  }
}
