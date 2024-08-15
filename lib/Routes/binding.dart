import 'package:get/get.dart';
import 'package:themovieflex/Controller/controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
  }
}
