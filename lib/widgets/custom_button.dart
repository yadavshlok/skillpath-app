// app/widgets/custom_button.dart
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isOutlined;
  final Color? color;
  final Widget? icon;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.color,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 6.5.h,
      decoration: BoxDecoration(
        gradient: isOutlined ? null : (color != null ? null : AppColors.primaryGradient),
        color: isOutlined ? Colors.transparent : color,
        borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
        border: isOutlined ? Border.all(color: AppColors.primaryBlue, width: 1.5) : null,
        boxShadow: isOutlined ? null : AppConstants.cardShadow,
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
          ),
        ),
        child: isLoading
            ? SizedBox(
          height: 2.5.h,
          width: 2.5.h,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor: AlwaysStoppedAnimation<Color>(
              isOutlined ? AppColors.primaryBlue : Colors.white,
            ),
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              SizedBox(width: 2.w),
            ],
            Text(
              text,
              style: TextStyle(
                fontSize: 13.8.sp,
                fontWeight: FontWeight.w600,
                color: isOutlined ? AppColors.primaryBlue : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
