
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class searchControllers extends GetxController {
  RxBool activeIndex1 = true.obs;
  RxBool activeIndex2 = false.obs;
  RxBool activeIndex3 = false.obs;

  void setActiveIndex(bool index1,bool index2,bool index3,) {
    activeIndex1.value = index1;
    activeIndex2.value = index2;
    activeIndex3.value = index3;
  }
}