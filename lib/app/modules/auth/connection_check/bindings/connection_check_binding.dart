import 'package:get/get.dart';

import '../controllers/connection_check_controller.dart';

class ConnectionCheckBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectionCheckController>(
      () => ConnectionCheckController(),
    );
  }
}
