// import 'package:get/get.dart';
// import 'package:tasks_manager/Core/controller/base_controller.dart';
// import 'package:tasks_manager/features/Tasks/domain/usecases/add_category.dart';
// import 'package:tasks_manager/features/Tasks/domain/usecases/get_categories.dart';

// class CategoryManagement extends BaseController{
//    final GetCategories getCategories;
//       final AddCategory addCategory;

// CategoryManagement({
//     required this.getCategories,
//     required this.addCategory,
//   });
//     final categoryErrorMessage = ''.obs;
//       final categories = <Map<String, dynamic>>[].obs;

//     Future<void> fetchCategories() async {
//     final result = await getCategories();
//     result.fold(
//       (failure) => categoryErrorMessage.value = failure.message,
//       (categories) => this.categories.value = categories,
//     );

//   }
// }
