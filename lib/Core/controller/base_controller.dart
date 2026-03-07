import 'package:get/get.dart';
import 'package:tasks_manager/Core/enums/view_state.dart';

class BaseController extends GetxController {
  @override
  final _state = ViewState.idle.obs;
  final _errorMessage = ''.obs;

  ViewState get state => _state.value;
  String get errorMessage => _errorMessage.value;
  setState(ViewState viewState, {String errorMessage = ''}) {
    this._errorMessage.value = errorMessage;
    _state.value = viewState;
  }
}
