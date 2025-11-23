// app/screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:skillpath/screens/skills_screen.dart';
import 'package:skillpath/screens/test_list_screen.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../routes/app_routes.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();
  final AuthController authController = Get.find<AuthController>();

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: Obx(() => IndexedStack(
        index: controller.selectedNavIndex.value,
        children: [
          _buildHomeContent(),
          _buildCareersPlaceholder(),
          TestListScreen(),
          SkillsScreen(),
          _buildFeedbackPlaceholder(),
        ],
      )),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildHomeContent() {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // App Bar
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: AppConstants.lightShadow,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(1.5.h),
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: AppConstants.cardShadow,
                        ),
                        child: Icon(
                          Icons.route,
                          color: Colors.white,
                          size: 2.8.h,
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        'SkillPath',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.notifications_outlined),
                        iconSize: 2.8.h,
                        color: AppColors.textDark,
                        onPressed: () {},
                      ),
                      SizedBox(width: 1.w),
                      GestureDetector(
                        onTap: () => Get.toNamed(Routes.SETTINGS),
                        child: Obx(() {
                          final user = authController.currentUser.value;
                          return Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: AppConstants.lightShadow,
                            ),
                            child: CircleAvatar(
                              radius: 2.2.h,
                              backgroundColor: AppColors.primaryBlue,
                              child: Text(
                                user?.initials ?? 'JD',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 2.5.h)),

          // Welcome Section
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Back, Student! 👋',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'Explore career paths and discover the skills you need to succeed',
                    style: TextStyle(
                      fontSize: 11.5.sp,
                      color: AppColors.textGrey,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 2.5.h)),

          // Search Bar
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: AppConstants.cardShadow,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search careers, skills...',
                    hintStyle: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textGrey,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.textGrey,
                      size: 2.7.h,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 2.h,
                    ),
                  ),
                  style: TextStyle(fontSize: 12.sp),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 2.5.h)),

          // Career Paths Header
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Explore Career Paths',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Career Cards - FIXED spacing
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            sliver: Obx(() => SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 2.h, // Reduced from 2.5.h
                crossAxisSpacing: 3.w, // Reduced from 4.w
                childAspectRatio: 0.8, // Adjusted for better fit
              ),
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final career = controller.careers[index];
                  return _buildMobileCareerCard(career);
                },
                childCount: controller.careers.length,
              ),
            )),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 2.5.h)),

          // Stats Section - REDUCED SIZE
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                children: [
                  _buildStatCard(
                    'Careers Explored',
                    controller.careersExplored.value.toString(),
                    AppColors.primaryBlue,
                    Icons.work_outline,
                  ),
                  SizedBox(height: 1.5.h),
                  _buildStatCard(
                    'Skills Assessed',
                    controller.skillsAssessed.value.toString(),
                    AppColors.primaryPurple,
                    Icons.stars,
                  ),
                  SizedBox(height: 1.5.h),
                  _buildStatCard(
                    'Tests Completed',
                    controller.testsCompleted.value.toString(),
                    AppColors.success,
                    Icons.check_circle_outline,
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 3.h)),
        ],
      ),
    );
  }

  Widget _buildMobileCareerCard(career) {
    return Container(
      padding: EdgeInsets.all(2.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: AppConstants.cardShadow,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 1.h),
          Container(
            padding: EdgeInsets.all(1.5.h),
            decoration: BoxDecoration(
              color: career.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              career.icon,
              color: career.color,
              size: 3.8.h,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            career.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 0.5.h),
          Expanded(
            child: Text(
              career.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10.sp,
                color: AppColors.textGrey,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: 0.6.h),
          SizedBox(
            width: double.infinity,
            height: 3.6.h,
            child: ElevatedButton(
              onPressed: () {
                Get.snackbar(
                  'Career Path',
                  'Exploring ${career.title}',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: career.color,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.zero,
              ),
              child: Text(
                'Explore',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 3.w), // Reduced from 3.h
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.8), color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: AppConstants.elevatedShadow,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(1.5.h), // Reduced from 1.8.h
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 3.2.h), // Reduced from 3.8.h
          ),
          SizedBox(width: 3.w),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 18.sp, // Reduced from 22.sp
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 3.w),
              Padding(
                padding: EdgeInsets.only(top: 0.8.h),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.sp, // Reduced from 11.sp
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCareersPlaceholder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.work_outline, size: 10.h, color: AppColors.textGrey),
          SizedBox(height: 2.h),
          Text(
            'Careers Page',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Coming soon...',
            style: TextStyle(fontSize: 14.sp, color: AppColors.textGrey),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackPlaceholder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.feedback_outlined, size: 10.h, color: AppColors.textGrey),
          SizedBox(height: 2.h),
          Text(
            'Feedback Page',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Coming soon...',
            style: TextStyle(fontSize: 14.sp, color: AppColors.textGrey),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Obx(() => Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: AppConstants.elevatedShadow,
      ),
      child: BottomNavigationBar(
        currentIndex: controller.selectedNavIndex.value,
        onTap: controller.changeNavIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: AppColors.textGrey,
        selectedFontSize: 11.2.sp, // Reduced from 11.sp
        unselectedFontSize: 10.sp, // Reduced from 10.sp
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        iconSize: 2.5.h, // REDUCED from 3.2.h - THIS FIXES THE ICON SIZE
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work_outline),
            activeIcon: Icon(Icons.work),
            label: 'Careers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            activeIcon: Icon(Icons.assignment),
            label: 'Tests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stars_outlined),
            activeIcon: Icon(Icons.stars),
            label: 'My Skills',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feedback_outlined),
            activeIcon: Icon(Icons.feedback),
            label: 'Feedback',
          ),
        ],
      ),
    ));
  }
}
