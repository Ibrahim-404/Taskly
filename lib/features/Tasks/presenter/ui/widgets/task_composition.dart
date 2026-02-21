import 'package:flutter/material.dart';

class TaskComposition extends StatefulWidget {
  const TaskComposition({super.key});

  @override
  State<TaskComposition> createState() => _TaskCompositionState();
}

class _TaskCompositionState extends State<TaskComposition> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ListView.builder(
              itemCount: ,
              itemBuilder: (context, index) {
                return CategoryWidget(categoryName: "Category $index");
                
              },
            ),
          ],
        ),
      ],
    );
  }
}
class CategoryWidget extends StatelessWidget {
 final String categoryName;
  const CategoryWidget({super.key, required this.categoryName});
  @override
  Widget build(BuildContext context) {
    return    GestureDetector(
                  onTap: () {
                  
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(
                            0,
                            3,
                          ), 
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.black),
                    ),
                    child: Text(categoryName),
                  ),
                );
  }
}