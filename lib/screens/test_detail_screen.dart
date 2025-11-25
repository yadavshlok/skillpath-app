// app/screens/tests/test_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/test_controller.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';

class TestDetailScreen extends StatelessWidget {
  final TestController controller = Get.find<TestController>();

  TestDetailScreen({Key? key}) : super(key: key);

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
          Get.arguments['careerTitle'] ?? 'Skill Assessment Test',
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        actions: [
          Obx(() => Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(Icons.access_time, size: 2.5.h, color: AppColors.primaryBlue),
                SizedBox(width: 1.5.w),
                Text(
                  controller.formattedTime.value, // This is the fix
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),

      body: Obx(() {
        if (controller.currentTest.value == null) {
          return Center(child: CircularProgressIndicator());
        }

        final test = controller.currentTest.value!;

        return SingleChildScrollView(
          padding: EdgeInsets.all(5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Test Header
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
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 3.w,
                            vertical: 0.8.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryBlue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            test.difficulty,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.primaryBlue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          '${test.duration} minutes',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.textGrey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      test.title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 2.h),

              // Problem Description
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
                    Text(
                      'Problem Description',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                    SizedBox(height: 1.5.h),
                    Text(
                      test.description,
                      style: TextStyle(
                        fontSize: 12.5.sp,
                        color: AppColors.textGrey,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    ...test.requirements.map((req) => Padding(
                      padding: EdgeInsets.only(bottom: 1.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${req.number}. ',
                            style: TextStyle(
                              fontSize: 12.5.sp,
                              color: AppColors.textDark,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              req.description,
                              style: TextStyle(
                                fontSize: 12.5.sp,
                                color: AppColors.textGrey,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                    if (test.bonusPoints.isNotEmpty) ...[
                      SizedBox(height: 2.h),
                      Text(
                        'Bonus Points:',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      ...test.bonusPoints.map((bonus) => Padding(
                        padding: EdgeInsets.only(bottom: 0.5.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('- ', style: TextStyle(fontSize: 12.sp)),
                            Expanded(
                              child: Text(
                                bonus,
                                style: TextStyle(
                                  fontSize: 12.5.sp,
                                  color: AppColors.textGrey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ],
                ),
              ),

              SizedBox(height: 2.h),

              // Skills Being Evaluated
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
                    Text(
                      'Skills Being Evaluated',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                    SizedBox(height: 1.5.h),
                    Wrap(
                      spacing: 2.w,
                      runSpacing: 1.h,
                      children: test.skills
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
                            fontSize: 12.sp,
                            color: AppColors.primaryPurple,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ))
                          .toList(),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 2.h),

              // Solution Input
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
                    Text(
                      'Your Solution',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                    SizedBox(height: 1.5.h),
                    Text(
                      'Write your code or explanation',
                      style: TextStyle(
                        fontSize: 12.5.sp,
                        color: AppColors.textGrey,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Container(
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: AppColors.bgLight,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.borderGrey),
                      ),
                      child: TextField(
                        maxLines: null,
                        expands: true,
                        style: TextStyle(
                          fontSize: 11.5.sp,
                          fontFamily: 'Courier',
                        ),
                        decoration: InputDecoration(
                          hintText: '// Write your solution here...\n'
                              '// Example:\n'
                              'const express = require(\'express\');\n'
                              'const app = express();\n\n'
                              '// Your code here...',
                          hintStyle: TextStyle(
                            fontSize: 11.sp,
                            color: AppColors.textGrey,
                            fontFamily: 'Courier',
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(2.h),
                        ),
                        onChanged: (value) {
                          controller.solutionCode.value = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 2.h),

              // Upload Section
              Container(
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColors.borderGrey,
                    width: 1.5,
                  ),
                  boxShadow: AppConstants.lightShadow,
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.cloud_upload_outlined,
                      size: 6.h,
                      color: AppColors.textGrey,
                    ),
                    SizedBox(height: 1.5.h),
                    Text(
                      'Click to upload or drag and drop',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.textDark,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      'Supported formats: .js, .ts, .py, .java, .zip',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 3.h),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Obx(() => CustomButton(
                      text: 'Submit Solution 🚀',
                      onPressed: controller.submitTest,
                      isLoading: controller.isLoading.value,
                    )),
                  ),
                ],
              ),

              SizedBox(height: 2.h),
            ],
          ),
        );
      }),
    );
  }
}
