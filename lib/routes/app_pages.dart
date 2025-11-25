import 'package:get/get.dart';
import '../bindings/auth_binding.dart';
import '../bindings/home_binding.dart';
import '../bindings/test_binding.dart';
import '../bindings/settings_binding.dart';
import '../screens/career_assessment_screen.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/skills_screen.dart';
import '../screens/test_detail_screen.dart';
import '../screens/test_feedback_screen.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.CAREER_ASSESSMENT, // ADD THIS
      page: () => CareerAssessmentScreen(),
    ),
    GetPage(
      name: Routes.TEST_FEEDBACK, // ADD THIS
      page: () => TestFeedbackScreen(),
    ),
    GetPage(
      name: Routes.SIGNUP,
      page: () => SignupScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.TEST_DETAIL,
      page: () => TestDetailScreen(),
      binding: TestBinding(),
    ),
    GetPage(
      name: Routes.SKILLS,
      page: () => SkillsScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => SettingsScreen(),
      binding: SettingsBinding(),
    ),
  ];
}
