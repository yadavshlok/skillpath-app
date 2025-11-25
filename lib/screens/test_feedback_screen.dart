// app/screens/tests/test_feedback_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';
import '../../routes/app_routes.dart';
import '../models/test_result_model.dart';

class TestFeedbackScreen extends StatelessWidget {
  const TestFeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get test result from arguments
    final TestResult result = Get.arguments['result'];

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: AppColors.textDark, size: 2.5.h),
          onPressed: () => Get.offAllNamed(Routes.HOME),
        ),
        title: Text(
          'Test Feedback',
          style: TextStyle(
            fontSize: 18.sp,
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
            // Score Card
            _buildScoreCard(result),

            SizedBox(height: 2.h),

            // Overall Feedback
            _buildFeedbackSection(result),

            SizedBox(height: 2.h),

            // Strengths
            _buildStrengthsSection(result.strengths),

            SizedBox(height: 2.h),

            // Areas to Improve
            _buildAreasToImproveSection(result.areasToImprove),

            SizedBox(height: 2.h),

            // Skills to Develop
            _buildSkillsToDevSection(result.skillsToDevelop),

            SizedBox(height: 2.h),

            // Your Solution
            _buildSolutionSection(result.userSolution),

            SizedBox(height: 2.h),

            // Action Buttons
            _buildActionButtons(),

            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreCard(TestResult result) {
    Color scoreColor = result.percentage >= 70
        ? AppColors.success
        : result.percentage >= 50
        ? AppColors.warning
        : AppColors.error;

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [scoreColor.withOpacity(0.8), scoreColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: AppConstants.elevatedShadow,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Score',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${result.score}',
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 1.h, left: 1.w),
                        child: Text(
                          '/ ${result.totalScore}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(2.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Column(
                  children: [
                    Text(
                      result.grade,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '${result.percentage.toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.category, color: Colors.white, size: 2.5.h),
                SizedBox(width: 2.w),
                Text(
                  result.careerTitle,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackSection(TestResult result) {
    return Container(
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
              Icon(Icons.feedback_outlined, color: AppColors.primaryBlue, size: 2.7.h),
              SizedBox(width: 2.w),
              Text(
                'Overall Feedback',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.5.h),
          Text(
            result.feedback,
            style: TextStyle(
              fontSize: 12.5.sp,
              color: AppColors.textGrey,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStrengthsSection(List<String> strengths) {
    return Container(
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
              Icon(Icons.star, color: AppColors.success, size: 2.7.h),
              SizedBox(width: 2.w),
              Text(
                'Strengths',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.5.h),
          ...strengths.map((strength) => Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 0.8.h, right: 2.w),
                  width: 0.8.h,
                  height: 0.8.h,
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    strength,
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      color: AppColors.textGrey,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildAreasToImproveSection(List<String> areas) {
    return Container(
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
              Icon(Icons.trending_up, color: AppColors.warning, size: 2.7.h),
              SizedBox(width: 2.w),
              Text(
                'Areas to Improve',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.5.h),
          ...areas.map((area) => Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 0.8.h, right: 2.w),
                  width: 0.8.h,
                  height: 0.8.h,
                  decoration: BoxDecoration(
                    color: AppColors.warning,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    area,
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      color: AppColors.textGrey,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildSkillsToDevSection(List<String> skills) {
    return Container(
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
              Icon(Icons.lightbulb_outline, color: AppColors.primaryPurple, size: 2.7.h),
              SizedBox(width: 2.w),
              Text(
                'Skills to Develop',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.5.h),
          Wrap(
            spacing: 2.w,
            runSpacing: 1.h,
            children: skills
                .map((skill) => Container(
              padding: EdgeInsets.symmetric(
                horizontal: 3.w,
                vertical: 1.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.primaryPurple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                skill,
                style: TextStyle(
                  fontSize: 11.5.sp,
                  color: AppColors.primaryPurple,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSolutionSection(String solution) {
    return Container(
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
              Icon(Icons.code, color: AppColors.primaryBlue, size: 2.7.h),
              SizedBox(width: 2.w),
              Text(
                'Your Solution',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.5.h),
          Container(
            padding: EdgeInsets.all(2.h),
            decoration: BoxDecoration(
              color: AppColors.bgLight,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.borderGrey),
            ),
            child: Text(
              solution,
              style: TextStyle(
                fontSize: 11.5.sp,
                fontFamily: 'Courier',
                color: AppColors.textDark,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        CustomButton(
          text: 'Explore More Careers 🚀',
          onPressed: () => Get.offAllNamed(Routes.HOME),
        ),
        SizedBox(height: 1.5.h),
        CustomButton(
          text: 'View All Tests',
          onPressed: () {
            Get.offAllNamed(Routes.HOME);
            // Navigate to tests tab
          },
          isOutlined: true,
        ),
      ],
    );
  }
}
