import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/features/Tasks/presenter/controllers/task_controller.dart';
import 'package:tasks_manager/features/Tasks/presenter/ui/widgets/task_composition.dart';

class TaskMainScreen extends StatefulWidget {
  TaskMainScreen({super.key});

  @override
  State<TaskMainScreen> createState() => _TaskMainScreenState();
}

class _TaskMainScreenState extends State<TaskMainScreen> {
  final RxBool isSubTask = false.obs;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController mainDescriptionController =
      TextEditingController();
  final TextEditingController SubTask1Controller = TextEditingController();
  final TextEditingController SubTask1DescraptionController =
      TextEditingController();
  // TextEditingController SubTask3Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find();
    return Scaffold(
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              elevation: 1,
              clipBehavior: Clip.antiAlias,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.7,
                ),

                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Add New Task",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          CustomTextFormField(controller: titleController),
                          const SizedBox(height: 8),
                          CustomTextFormField(
                            controller: mainDescriptionController,
                            maxLines: 3,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Expanded(child: Text("Category")),
                              Expanded(
                                child: Obx(
                                  () => DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey.shade100,

                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 12,
                                          ),

                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide.none,
                                      ),

                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                          color: Colors.blue.shade300,
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                    isExpanded: true,
                                    hint: const Text("Select"),
                                    items: taskController.categories.map((cat) {
                                      return DropdownMenuItem<String>(
                                        value: cat['category_name'].toString(),
                                        child: Text(
                                          cat['category_name'].toString(),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      // Handle category selection
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () async {
                                    final date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2100),
                                    );
                                    // if (date != null) setState(() => selectedDate = date);
                                  },
                                  icon: const Icon(Icons.calendar_month),
                                  label: Text(
                                    // selectedDate == null
                                    //     ? "Set Date"
                                    //     : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                                    "Set Date",
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () async {
                                    final time = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );
                                    // if (time != null) setState(() => selectedTime = time);
                                  },
                                  icon: const Icon(Icons.access_time),
                                  label: Text(
                                    //   selectedTime == null
                                    //       ? "Set Time"
                                    //       : selectedTime!.format(context),
                                    // ),
                                    "Set Time",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Add Sub Task "),

                              Obx(
                                () => AnimatedRotation(
                                  turns: isSubTask.value ? 0.5 : 0.0,
                                  duration: Duration(milliseconds: 300),
                                  child: IconButton(
                                    onPressed: () {
                                      isSubTask.value = !isSubTask.value;
                                    },
                                    icon: Icon(
                                      isSubTask.value == true
                                          ? Icons.keyboard_arrow_up_rounded
                                          : Icons.arrow_forward_ios,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Obx(
                            () => AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder: (child, animation) {
                                return SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0, -0.3),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                                );
                              },
                              child: isSubTask.value
                                  ? CustomRowForSubTask(
                                      controller: SubTask1Controller,
                                      descraption:
                                          SubTask1DescraptionController,
                                    )
                                  : const SizedBox(key: ValueKey("empty")),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              // Logic to add task
                              Navigator.pop(context);
                            },
                            child: const Text("Add Task"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: TaskComposition(),
    );
  }
}

class SubTaskWidget extends StatelessWidget {
  final TextEditingController subTask1Controller;
  final TextEditingController subTask2Controller;
  final TextEditingController subTask3Controller;
  const SubTaskWidget({
    super.key,
    required this.subTask1Controller,
    required this.subTask2Controller,
    required this.subTask3Controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(controller: subTask1Controller),
        CustomTextFormField(controller: subTask2Controller),
        CustomTextFormField(controller: subTask3Controller),
      ],
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final int maxLines;

  const CustomTextFormField({
    super.key,
    required this.controller,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: "Enter Task Name",

        filled: true,
        fillColor: Colors.grey.shade100,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.blue.shade300, width: 1.5),
        ),
      ),
    );
  }
}

class CustomRowForSubTask extends StatelessWidget {
  final TextEditingController controller;
  final TextEditingController descraption;

  CustomRowForSubTask({
    super.key,
    required this.controller,
    required this.descraption,
  });

  final RxBool isExpanded = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Row(
            children: [
              Expanded(child: CustomTextFormField(controller: controller)),
              const SizedBox(width: 8),
              AnimatedRotation(
                turns: isExpanded.value ? 0.5 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: IconButton(
                  onPressed: () {
                    isExpanded.value = !isExpanded.value;
                  },
                  icon: Icon(
                    isExpanded.value
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.arrow_forward_ios,
                  ),
                ),
              ),
            ],
          ),

          // 👇 Description
          if (isExpanded.value)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CustomTextFormField(controller: descraption, maxLines: 3),
            ),
        ],
      ),
    );
  }
}
