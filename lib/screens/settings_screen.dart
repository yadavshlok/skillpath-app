// app/screens/settings/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/settings_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class SettingsScreen extends StatelessWidget {
  final SettingsController controller = Get.put(SettingsController());
  final AuthController authController = Get.find<AuthController>();

  SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textDark, size: 2.7.h),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Manage your account and preferences',
              style: TextStyle(
                fontSize: 11.5.sp,
                color: AppColors.textGrey,
              ),
            ),
            SizedBox(height: 2.5.h),

            // Profile Information
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: AppConstants.cardShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person_outline, color: AppColors.primaryBlue, size: 2.7.h),
                      SizedBox(width: 2.w),
                      Text(
                        'Profile Information',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),

                  // Profile Photo
                  Center(
                    child: Stack(
                      children: [
                        Obx(() {
                          final user = authController.currentUser.value;
                          return Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: AppConstants.cardShadow,
                            ),
                            child: CircleAvatar(
                              radius: 5.h,
                              backgroundColor: AppColors.primaryBlue,
                              child: Text(
                                user?.initials ?? 'JD',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          );
                        }),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(0.8.h),
                            decoration: BoxDecoration(
                              color: AppColors.primaryBlue,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2.5),
                              boxShadow: AppConstants.lightShadow,
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 2.2.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Change Photo',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'JPG, PNG or GIF. Max size 2MB',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),

                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: controller.firstNameController,
                          hintText: 'John',
                          labelText: 'First Name',
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: CustomTextField(
                          controller: controller.lastNameController,
                          hintText: 'Doe',
                          labelText: 'Last Name',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),

                  CustomTextField(
                    controller: controller.emailController,
                    hintText: 'john.doe@example.com',
                    labelText: 'Email Address',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 2.h),

                  CustomTextField(
                    controller: controller.phoneController,
                    hintText: '+1 (555) 123-4567',
                    labelText: 'Phone Number',
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 2.h),

                  Obx(() => CustomButton(
                    text: 'Save Changes',
                    onPressed: controller.saveChanges,
                    isLoading: controller.isLoading.value,
                  )),
                ],
              ),
            ),

            SizedBox(height: 2.h),

            // Career Goal
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: AppConstants.cardShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.work_outline, color: AppColors.primaryPurple, size: 2.7.h),
                      SizedBox(width: 2.w),
                      Text(
                        'Career Goal',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),

                  Text(
                    'Current Career Interest',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  SizedBox(height: 0.8.h),
                  Obx(() => Container(
                    decoration: BoxDecoration(
                      boxShadow: AppConstants.lightShadow,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: controller.selectedCareer.value,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.textDark,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 2.2.h,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: AppColors.borderGrey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: AppColors.borderGrey),
                        ),
                      ),
                      items: [
                        'Software Developer',
                        'Data Scientist',
                        'Cloud Engineer',
                        'Cyber Security',
                        'AI/ML Engineer',
                        'Web Developer',
                      ].map((career) => DropdownMenuItem(
                        value: career,
                        child: Text(career),
                      )).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          controller.selectedCareer.value = value;
                        }
                      },
                    ),
                  )),
                  SizedBox(height: 2.h),

                  Text(
                    'Experience Level',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  SizedBox(height: 0.8.h),
                  Obx(() => Container(
                    decoration: BoxDecoration(
                      boxShadow: AppConstants.lightShadow,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: controller.selectedExperience.value,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.textDark,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 2.2.h,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: AppColors.borderGrey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: AppColors.borderGrey),
                        ),
                      ),
                      items: [
                        'Beginner',
                        'Intermediate',
                        'Advanced',
                        'Expert',
                      ].map((level) => DropdownMenuItem(
                        value: level,
                        child: Text(level),
                      )).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          controller.selectedExperience.value = value;
                        }
                      },
                    ),
                  )),
                ],
              ),
            ),

            SizedBox(height: 2.h),

            // Notification Preferences
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: AppConstants.cardShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.notifications_outlined, color: AppColors.success, size: 2.7.h),
                      SizedBox(width: 2.w),
                      Text(
                        'Notification Preferences',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.5.h),

                  _buildSwitchTile(
                    icon: Icons.email_outlined,
                    title: 'Email Notifications',
                    subtitle: 'Receive updates via email',
                    value: controller.emailNotifications,
                    onChanged: () => controller.toggleNotification('email'),
                  ),
                  _buildSwitchTile(
                    icon: Icons.bar_chart,
                    title: 'Weekly Progress Reports',
                    subtitle: 'Get weekly summaries',
                    value: controller.weeklyReports,
                    onChanged: () => controller.toggleNotification('weekly'),
                  ),
                  _buildSwitchTile(
                    icon: Icons.alarm,
                    title: 'Test Reminders',
                    subtitle: 'Reminders for assessments',
                    value: controller.testReminders,
                    onChanged: () => controller.toggleNotification('test'),
                  ),
                ],
              ),
            ),

            SizedBox(height: 2.h),

            // Appearance
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: AppConstants.cardShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.palette_outlined, color: AppColors.warning, size: 2.7.h),
                      SizedBox(width: 2.w),
                      Text(
                        'Appearance',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.5.h),

                  _buildSwitchTile(
                    icon: Icons.dark_mode_outlined,
                    title: 'Dark Mode',
                    subtitle: 'Toggle dark theme',
                    value: controller.darkMode,
                    onChanged: controller.toggleDarkMode,
                  ),
                ],
              ),
            ),

            SizedBox(height: 2.h),

            // Account Actions
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.error.withOpacity(0.3), width: 1.5),
                boxShadow: AppConstants.cardShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account Actions',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  SizedBox(height: 0.8.h),
                  Text(
                    'Manage your account status',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: AppColors.textGrey,
                    ),
                  ),
                  SizedBox(height: 2.h),

                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 5.h,
                          child: OutlinedButton.icon(
                            onPressed: authController.logout,
                            icon: Icon(Icons.logout, color: AppColors.error, size: 2.3.h),
                            label: Text(
                              'Logout',
                              style: TextStyle(
                                color: AppColors.error,
                                fontSize: 11.5.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: AppColors.error, width: 1.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: SizedBox(
                          height: 5.h,
                          child: OutlinedButton(
                            onPressed: () {
                              Get.dialog(
                                AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  title: Text(
                                    'Delete Account',
                                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
                                  ),
                                  content: Text(
                                    'Are you sure you want to delete your account? This action cannot be undone.',
                                    style: TextStyle(fontSize: 11.sp),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Get.back(),
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(fontSize: 12.sp),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Get.back();
                                        authController.logout();
                                      },
                                      child: Text(
                                        'Delete',
                                        style: TextStyle(
                                          color: AppColors.error,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                color: AppColors.textDark,
                                fontSize: 11.5.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: AppColors.borderGrey, width: 1.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 3.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required RxBool value,
    required VoidCallback onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.5.h),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textGrey, size: 2.7.h),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ),
          ),
          Obx(() => Switch(
            value: value.value,
            onChanged: (_) => onChanged(),
            activeColor: AppColors.primaryBlue,
          )),
        ],
      ),
    );
  }
}
