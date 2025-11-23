
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../controllers/skills_controller.dart';
import '../controllers/auth_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<SkillsController>(() => SkillsController());
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
