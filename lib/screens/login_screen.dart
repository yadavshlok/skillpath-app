// app/screens/auth/login_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/auth_controller.dart';
import '../../routes/app_routes.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  final AuthController controller = Get.find<AuthController>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 8.h),

                // Logo/Icon
                Container(
                  padding: EdgeInsets.all(3.h),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: AppConstants.elevatedShadow,
                  ),
                  child: Icon(
                    Icons.route,
                    color: Colors.white,
                    size: 7.h,
                  ),
                ),

                SizedBox(height: 3.h),

                // Welcome Text
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),

                SizedBox(height: 1.h),

                Text(
                  'Continue your skill development journey',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: AppColors.textGrey,
                  ),
                ),

                SizedBox(height: 3.5.h),

                // Email Field
                CustomTextField(
                  controller: controller.loginEmailController,
                  hintText: 'you@example.com',
                  labelText: 'Email Address',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),

                SizedBox(height: 2.h),

                // Password Field
                Obx(() => CustomTextField(
                  controller: controller.loginPasswordController,
                  hintText: 'Enter your password',
                  labelText: 'Password',
                  prefixIcon: Icons.lock_outline,
                  obscureText: !controller.isPasswordVisible.value,
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isPasswordVisible.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.textGrey,
                      size: 2.7.h,
                    ),
                    onPressed: controller.togglePasswordVisibility,
                  ),
                )),

                SizedBox(height: 4.h),

                // Login Button
                Obx(() => CustomButton(
                  text: 'Continue Learning 🎯',
                  onPressed: controller.login,
                  isLoading: controller.isLoading.value,
                )),

                SizedBox(height: 3.h),

                // Sign up link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        fontSize: 12.5.sp,
                        color: AppColors.textGrey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(Routes.SIGNUP),
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 12.5.sp,
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 3.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
