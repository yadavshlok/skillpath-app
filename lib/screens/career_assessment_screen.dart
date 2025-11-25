// app/screens/careers/career_assessment_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/career_assessment_controller.dart';
import '../../routes/app_routes.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';

class CareerAssessmentScreen extends StatelessWidget {
  final CareerAssessmentController controller = Get.put(CareerAssessmentController());

  CareerAssessmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get career data from arguments
    final careerTitle = Get.arguments['title'] ?? 'Software Developer';
    final careerColor = Get.arguments['color'] ?? AppColors.primaryBlue;

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textDark, size: 2.5.h),
          onPressed: () => Get.back(),
        ),
        title: Text(
          careerTitle,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  // Header Section
                  SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.all(5.w),
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [careerColor.withOpacity(0.8), careerColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: AppConstants.elevatedShadow,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rate Your Knowledge',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            'Help us understand your current skill level in $careerTitle',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white.withOpacity(0.9),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(child: SizedBox(height: 1.h)),

                  // Skills Rating Section
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Row(
                        children: [
                          Icon(Icons.trending_up, color: AppColors.primaryBlue, size: 2.7.h),
                          SizedBox(width: 2.w),
                          Text(
                            'Required Skills',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(child: SizedBox(height: 1.5.h)),

                  // Skills Sliders
                  SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: AppConstants.cardShadow,
                      ),
                      child: Obx(() => Column(
                        children: controller.skills
                            .map((skill) => _buildSkillSlider(skill))
                            .toList(),
                      )),
                    ),
                  ),

                  SliverToBoxAdapter(child: SizedBox(height: 2.h)),
                ],
              ),
            ),

            // Bottom Button
            Container(
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: AppConstants.elevatedShadow,
              ),
              child: Obx(() => CustomButton(
                text: 'Start Assessment Test 🚀',
                onPressed: controller.isAllSkillsRated()
                    ? () => Get.toNamed(Routes.TEST_DETAIL, arguments: {
                  'testId': '1',
                  'careerTitle': careerTitle,
                })
                    : () {
                  Get.snackbar(
                    'Rate All Skills',
                    'Please rate all skills before starting the test',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: AppColors.warning,
                    colorText: Colors.white,
                  );
                },
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillSlider(skill) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                skill.name,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              Obx(() => Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '${skill.level.value.toInt()}/5', // FIXED: Added .value
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryBlue,
                  ),
                ),
              )),
            ],
          ),
          SizedBox(height: 1.h),
          Obx(() => SliderTheme(
            data: SliderThemeData(
              trackHeight: 0.8.h,
              activeTrackColor: AppColors.primaryBlue,
              inactiveTrackColor: AppColors.borderGrey,
              thumbColor: AppColors.primaryBlue,
              overlayColor: AppColors.primaryBlue.withOpacity(0.2),
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 1.3.h),
            ),
            child: Slider(
              value: skill.level.value, // FIXED: Added .value
              min: 0,
              max: 5,
              divisions: 5,
              onChanged: (value) {
                controller.updateSkillLevel(skill.id, value);
              },
            ),
          )),
        ],
      ),
    );
  }
}
