import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum AppButtonVariant { primary, secondary, outline, ghost, danger }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;
  final double? height;
  final double? fontSize;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.isFullWidth = true,
    this.icon,
    this.height,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    ButtonStyle? style;
    Widget child;

    switch (variant) {
      case AppButtonVariant.primary:
        style = ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(height ?? 48.h),
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        );
        break;
      case AppButtonVariant.secondary:
        style = ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(height ?? 48.h),
          backgroundColor: theme.colorScheme.secondary,
          foregroundColor: theme.colorScheme.onSecondary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        );
        break;
      case AppButtonVariant.outline:
        style = OutlinedButton.styleFrom(
          minimumSize: Size.fromHeight(height ?? 48.h),
          side: BorderSide(color: theme.colorScheme.primary, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        );
        break;
      case AppButtonVariant.ghost:
        style = TextButton.styleFrom(
          minimumSize: Size.fromHeight(height ?? 48.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        );
        break;
      case AppButtonVariant.danger:
        style = ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(height ?? 48.h),
          backgroundColor: theme.colorScheme.error,
          foregroundColor: theme.colorScheme.onError,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        );
        break;
    }

    if (isLoading) {
      child = SizedBox(
        height: 20.h,
        width: 20.h,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(
            variant == AppButtonVariant.outline
                ? theme.colorScheme.primary
                : theme.colorScheme.onPrimary,
          ),
        ),
      );
    } else if (icon != null) {
      child = Row(
        mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20.sp),
          SizedBox(width: 8.w),
          Text(
            label,
            style: TextStyle(fontSize: fontSize ?? 15.sp, fontWeight: FontWeight.w600),
          ),
        ],
      );
    } else {
      child = Text(
        label,
        style: TextStyle(fontSize: fontSize ?? 15.sp, fontWeight: FontWeight.w600),
      );
    }

    Widget button;
    if (variant == AppButtonVariant.outline) {
      button = OutlinedButton(onPressed: isLoading ? null : onPressed, style: style, child: child);
    } else if (variant == AppButtonVariant.ghost) {
      button = TextButton(onPressed: isLoading ? null : onPressed, style: style, child: child);
    } else {
      button = ElevatedButton(onPressed: isLoading ? null : onPressed, style: style, child: child);
    }

    if (isFullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }
    return button;
  }
}
