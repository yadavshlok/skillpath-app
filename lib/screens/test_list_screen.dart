// app/screens/tests/test_list_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../routes/app_routes.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';

class TestListScreen extends StatelessWidget {
  const TestListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Skill Assessment Tests',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      'Show us what you can do!',
                      style: TextStyle(
                        fontSize: 11.5.sp,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildTestCard(
                    title: 'Build a REST API for Task Management',
                    difficulty: 'Intermediate',
                    duration: 45,
                    skills: ['Node.js', 'Express', 'REST API', 'Error Handling'],
                  ),
                  SizedBox(height: 2.h),
                  _buildTestCard(
                    title: 'Create a React Dashboard',
                    difficulty: 'Advanced',
                    duration: 60,
                    skills: ['React', 'TypeScript', 'Redux', 'Material-UI'],
                  ),
                  SizedBox(height: 2.h),
                  _buildTestCard(
                    title: 'Database Design Challenge',
                    difficulty: 'Intermediate',
                    duration: 30,
                    skills: ['SQL', 'Database Design', 'Normalization'],
                  ),
                  SizedBox(height: 2.h),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestCard({
    required String title,
    required String difficulty,
    required int duration,
    required List<String> skills,
  }) {
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
                decoration: BoxDecoration(
                  color: _getDifficultyColor(difficulty).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  difficulty,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: _getDifficultyColor(difficulty),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              Icon(Icons.access_time, size: 2.5.h, color: AppColors.textGrey),
              SizedBox(width: 1.w),
              Text(
                '$duration minutes',
                style: TextStyle(
                  fontSize: 11.sp,
                  color: AppColors.textGrey,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          SizedBox(height: 1.5.h),
          Wrap(
            spacing: 2.w,
            runSpacing: 1.h,
            children: skills
                .map((skill) => Container(
              padding: EdgeInsets.symmetric(
                horizontal: 3.w,
                vertical: 0.8.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                skill,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ))
                .toList(),
          ),
          SizedBox(height: 2.h),
          SizedBox(
            width: double.infinity,
            height: 5.h,
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.TEST_DETAIL, arguments: {'testId': '1'});
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Start Test',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return AppColors.success;
      case 'intermediate':
        return AppColors.warning;
      case 'advanced':
        return AppColors.error;
      default:
        return AppColors.textGrey;
    }
  }
}
