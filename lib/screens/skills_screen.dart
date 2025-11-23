import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../controllers/skills_controller.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';

class SkillsScreen extends StatelessWidget {
  final SkillsController controller = Get.put(SkillsController());

  SkillsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(AppConstants.defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rate Your Skills',
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      'Help us understand your current skill level to provide personalized recommendations',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Overall Skill Level
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
                child: Obx(() => Container(
                  padding: EdgeInsets.all(2.h),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(AppConstants.cardRadius),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryBlue.withOpacity(0.3),
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Overall Skill Level',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            '${controller.overallSkillLevel.value.toStringAsFixed(1)}/5.0',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.emoji_events,
                        size: 5.h,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ],
                  ),
                )),
              ),
            ),

            SizedBox(height: 3.h).toSliver(),

            // Skills Distribution Section
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
                padding: EdgeInsets.all(AppConstants.defaultPadding),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppConstants.cardRadius),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Skill Distribution',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      'Visual representation of your skill levels',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.textGrey,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Obx(() => _buildRadarChart()),
                  ],
                ),
              ),
            ),

            SizedBox(height: 3.h).toSliver(),

            // Technical Skills
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
                child: Row(
                  children: [
                    Icon(Icons.trending_up, color: AppColors.primaryBlue, size: 2.5.h),
                    SizedBox(width: 2.w),
                    Text(
                      'Technical Skills',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 1.5.h).toSliver(),

            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
                padding: EdgeInsets.all(AppConstants.defaultPadding),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppConstants.cardRadius),
                ),
                child: Obx(() => Column(
                  children: controller.technicalSkills
                      .map((skill) => _buildSkillSlider(skill))
                      .toList(),
                )),
              ),
            ),

            SizedBox(height: 3.h).toSliver(),

            // Soft Skills
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
                child: Row(
                  children: [
                    Icon(Icons.emoji_people, color: AppColors.primaryPurple, size: 2.5.h),
                    SizedBox(width: 2.w),
                    Text(
                      'Soft Skills',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 1.5.h).toSliver(),

            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
                padding: EdgeInsets.all(AppConstants.defaultPadding),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppConstants.cardRadius),
                ),
                child: Obx(() => Column(
                  children: controller.softSkills
                      .map((skill) => _buildSkillSlider(skill))
                      .toList(),
                )),
              ),
            ),

            SizedBox(height: 3.h).toSliver(),
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
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              Text(
                '${skill.level.toInt()}/5',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryBlue,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 0.8.h,
              activeTrackColor: AppColors.primaryBlue,
              inactiveTrackColor: AppColors.borderGrey,
              thumbColor: AppColors.primaryBlue,
              overlayColor: AppColors.primaryBlue.withOpacity(0.2),
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 1.2.h),
            ),
            child: Slider(
              value: skill.level,
              min: 0,
              max: 5,
              divisions: 5,
              onChanged: (value) {
                controller.updateSkillLevel(skill.id, value);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadarChart() {
    final skills = [...controller.technicalSkills, ...controller.softSkills];
    if (skills.isEmpty) return SizedBox();

    return SizedBox(
      height: 35.h,
      child: RadarChart(
        RadarChartData(
          radarShape: RadarShape.polygon,
          tickCount: 5,
          ticksTextStyle: TextStyle(
            fontSize: 8.sp,
            color: Colors.transparent,
          ),
          radarBorderData: BorderSide(color: AppColors.borderGrey, width: 1.5),
          gridBorderData: BorderSide(color: AppColors.borderGrey.withOpacity(0.3)),
          tickBorderData: BorderSide(color: Colors.transparent),
          getTitle: (index, angle) {
            if (index >= skills.length) return RadarChartTitle(text: '');
            return RadarChartTitle(
              text: skills[index].name.split(' ').first,
              angle: angle,
            );
          },
          dataSets: [
            RadarDataSet(
              fillColor: AppColors.primaryBlue.withOpacity(0.2),
              borderColor: AppColors.primaryBlue,
              borderWidth: 2,
              dataEntries: skills
                  .map((skill) => RadarEntry(value: skill.level))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

extension SizedBoxExt on SizedBox {
  SliverToBoxAdapter toSliver() => SliverToBoxAdapter(child: this);
}
