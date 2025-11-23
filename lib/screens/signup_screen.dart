import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/auth_controller.dart';
import '../../routes/app_routes.dart';
import '../../utils/colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class SignupScreen extends StatelessWidget {
  final AuthController controller = Get.find<AuthController>();

  SignupScreen({Key? key}) : super(key: key);

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
                SizedBox(height: 5.h),

                // Logo/Icon
                Container(
                  padding: EdgeInsets.all(3.h),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryBlue.withOpacity(0.3),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.route,
                    color: Colors.white,
                    size: 8.h,
                  ),
                ),

                SizedBox(height: 3.h),

                // Title
                Text(
                  'Create Your Account',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),

                SizedBox(height: 1.h),

                Text(
                  'Start your journey to career success',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    color: AppColors.textGrey,
                  ),
                ),

                SizedBox(height: 3.h),

                // Full Name Field
                CustomTextField(
                  controller: controller.signupNameController,
                  hintText: 'Enter your full name',
                  labelText: 'Full Name',
                  prefixIcon: Icons.person_outline,
                ),

                SizedBox(height: 2.h),

                // Email Field
                CustomTextField(
                  controller: controller.signupEmailController,
                  hintText: 'you@example.com',
                  labelText: 'Email Address',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),

                SizedBox(height: 2.h),

                // Password Field
                Obx(() => CustomTextField(
                  controller: controller.signupPasswordController,
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
                      size: 2.5.h,
                    ),
                    onPressed: controller.togglePasswordVisibility,
                  ),
                )),

                SizedBox(height: 2.h),

                // Confirm Password Field
                Obx(() => CustomTextField(
                  controller: controller.signupConfirmPasswordController,
                  hintText: 'Confirm your password',
                  labelText: 'Confirm Password',
                  prefixIcon: Icons.lock_outline,
                  obscureText: !controller.isPasswordVisible.value,
                )),

                SizedBox(height: 3.h),

                // Signup Button
                Obx(() => CustomButton(
                  text: 'Start Your Skill Journey 🚀',
                  onPressed: controller.register,
                  isLoading: controller.isLoading.value,
                )),

                SizedBox(height: 3.h),

                // Login link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(
                        fontSize: 12.5.sp,
                        color: AppColors.textGrey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Text(
                        'Sign in',
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
