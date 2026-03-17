import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/features/Tasks/presenter/controllers/task_controller.dart';
import 'package:tasks_manager/features/Tasks/presenter/ui/widgets/custom_search.dart';

class TaskComposition extends StatefulWidget {
  TaskComposition({super.key});
  final TextEditingController controller = TextEditingController();
  final SearchController searchController = SearchController();
  final FocusNode focusNode = FocusNode();
  @override
  State<TaskComposition> createState() => _TaskCompositionState();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
}

class _TaskCompositionState extends State<TaskComposition> {
  final TaskController taskController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomSearch(searchController: widget.searchController),
              SizedBox(
                height: 65,
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: taskController.categories.length + 2,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return const CategoryWidget(categoryName: "life");
                            } else if (index ==
                                taskController.categories.length + 1) {
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      child: GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () =>
                                            FocusScope.of(context).unfocus(),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Form(
                                            key: widget.formKey,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextFormField(
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter a category name';
                                                    }
                                                    FocusScope.of(
                                                      context,
                                                    ).unfocus();
                                                    FocusScope.of(
                                                      context,
                                                    ).unfocus();
                                                    return null;
                                                  },
                                                  controller: widget.controller,
                                                  decoration:
                                                      const InputDecoration(
                                                        border: OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                color:
                                                                    Colors.blue,
                                                              ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                Radius.circular(
                                                                  20,
                                                                ),
                                                              ),
                                                        ),
                                                        hintText:
                                                            "Category Name",
                                                      ),
                                                ),
                                                const SizedBox(height: 16),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            Colors.blueAccent,
                                                      ),
                                                  onPressed: () {
                                                    if (widget
                                                        .formKey
                                                        .currentState!
                                                        .validate()) {
                                                      taskController
                                                          .addANewCategory(
                                                            widget
                                                                .controller
                                                                .text,
                                                          );
                                                      Navigator.pop(context);
                                                      widget.controller.clear();
                                                    }
                                                  },
                                                  child: const Text("Add"),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: 10,
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    child: Icon(Icons.add, color: Colors.white),
                                  ),
                                ),
                              );
                            }
                            final category =
                                taskController.categories[index - 1];
                            return CategoryWidget(
                              categoryName:
                                  category['category_name'] ??
                                  'Category $index',
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  final String categoryName;
  const CategoryWidget({super.key, required this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 37, 29, 29).withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
          // borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue.shade200),
        ),
        child: Center(
          child: Text(
            categoryName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
