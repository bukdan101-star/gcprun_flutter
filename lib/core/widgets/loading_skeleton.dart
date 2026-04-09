import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class LoadingSkeleton extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final ShimmerDirection direction;
  final int itemCount;
  final Axis scrollDirection;
  final double itemSpacing;
  final bool isCircle;

  const LoadingSkeleton({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.direction = ShimmerDirection.ltr,
    this.itemCount = 1,
    this.scrollDirection = Axis.vertical,
    this.itemSpacing = 12,
    this.isCircle = false,
  });

  factory LoadingSkeleton.card({Key? key, double? width, double? height}) {
    return LoadingSkeleton(
      key: key,
      width: width,
      height: height ?? 120,
      borderRadius: BorderRadius.circular(16),
    );
  }

  factory LoadingSkeleton.list({Key? key, int count = 5}) {
    return LoadingSkeleton(
      key: key,
      itemCount: count,
    );
  }

  factory LoadingSkeleton.avatar({Key? key, double size = 48}) {
    return LoadingSkeleton(
      key: key,
      width: size,
      height: size,
      isCircle: true,
    );
  }

  factory LoadingSkeleton.text({
    Key? key,
    double? width,
    double height = 16,
  }) {
    return LoadingSkeleton(
      key: key,
      width: width,
      height: height,
      borderRadius: BorderRadius.circular(4),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
      highlightColor: isDark ? Colors.grey.shade700 : Colors.grey.shade100,
      direction: direction,
      period: const Duration(milliseconds: 1500),
      child: itemCount > 1
          ? _buildList()
          : _buildSingleItem(),
    );
  }

  Widget _buildSingleItem() {
    if (isCircle) {
      return Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      );
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildList() {
    if (scrollDirection == Axis.horizontal) {
      return SizedBox(
        height: height ?? 120.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: itemCount,
          separatorBuilder: (_, __) => SizedBox(width: itemSpacing.w),
          itemBuilder: (_, __) => Container(
            width: width ?? 140.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: borderRadius ?? BorderRadius.circular(16.r),
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (_, __) => SizedBox(height: itemSpacing.h),
      itemBuilder: (_, index) => _buildListItem(index),
    );
  }

  Widget _buildListItem(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width ?? double.infinity,
          height: height ?? 16.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: borderRadius ?? BorderRadius.circular(4.r),
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 14.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: borderRadius ?? BorderRadius.circular(4.r),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              width: 60.w,
              height: 14.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: borderRadius ?? BorderRadius.circular(4.r),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CardSkeleton extends StatelessWidget {
  final double? width;
  final double height;

  const CardSkeleton({
    super.key,
    this.width,
    this.height = 180,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                LoadingSkeleton.avatar(size: 40),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LoadingSkeleton.text(width: 120, height: 14),
                      SizedBox(height: 6.h),
                      LoadingSkeleton.text(width: 80, height: 12),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            LoadingSkeleton.text(height: 14),
            SizedBox(height: 8.h),
            LoadingSkeleton.text(width: 200, height: 12),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LoadingSkeleton.text(width: 100, height: 14),
                LoadingSkeleton.text(width: 60, height: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ListingCardSkeleton extends StatelessWidget {
  const ListingCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.grey.shade300,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoadingSkeleton.text(width: 120, height: 16),
                SizedBox(height: 8.h),
                LoadingSkeleton.text(height: 14),
                SizedBox(height: 4.h),
                LoadingSkeleton.text(width: 150, height: 12),
                SizedBox(height: 12.h),
                LoadingSkeleton.text(width: 80, height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
