

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class KeyboardController extends GetxController {
  RxBool isKeyboardVisible = false.obs;

  void setKeyboardVisibility(bool isVisible) {
    isKeyboardVisible.value = isVisible;
  }
}