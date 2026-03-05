import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../enum/view_state.dart';

class BaseController extends GetxController {
final _state =ViewState.idle.obs;
ViewState get state => _state.value;

}