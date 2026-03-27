import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SubTaskTextEditControllerModel {
  final TextEditingController subTaskTextEditingController;
  final TextEditingController subTaskDescriptionTextEditingController;
  final RxBool isSubTaskDone;

  SubTaskTextEditControllerModel({
    required this.subTaskTextEditingController,
    required this.subTaskDescriptionTextEditingController,
    bool initialDone = false,
  }) : isSubTaskDone = initialDone.obs;
}
