import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/custom_text_form_field.dart';

class CustomRowForSubTask extends StatelessWidget {
  final TextEditingController controller;
  final TextEditingController description;

  CustomRowForSubTask({
    super.key,
    required this.controller,
    required this.description,
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
              child: CustomTextFormField(controller: description, maxLines: 3),
            ),
        ],
      ),
    );
  }
}
