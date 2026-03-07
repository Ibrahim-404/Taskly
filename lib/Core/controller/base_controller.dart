import 'package:get/get.dart';
import 'package:tasks_manager/Core/enums/view_state.dart';

class BaseController extends GetxController {
  @override
  final _state = ViewState.idle.obs;
  
  get state => _state.value;
  
  setState(ViewState viewState) => _state.value = viewState;
}