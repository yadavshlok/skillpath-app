class ApiEndpoints {
  static const String baseUrl = 'https://your-api-url.com/api';

  // Auth endpoints
  static const String login = '$baseUrl/auth/login';
  static const String register = '$baseUrl/auth/register';
  static const String logout = '$baseUrl/auth/logout';

  // User endpoints
  static const String userProfile = '$baseUrl/user/profile';
  static const String updateProfile = '$baseUrl/user/update';

  // Career endpoints
  static const String careers = '$baseUrl/careers';
  static const String careerDetails = '$baseUrl/careers/';

  // Test endpoints
  static const String tests = '$baseUrl/tests';
  static const String testDetails = '$baseUrl/tests/';
  static const String submitTest = '$baseUrl/tests/submit';

  // Skills endpoints
  static const String skills = '$baseUrl/skills';
  static const String updateSkills = '$baseUrl/skills/update';
}
