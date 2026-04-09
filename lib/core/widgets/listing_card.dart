import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/currency_formatter.dart';

class ListingCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int price;
  final String? location;
  final String condition;
  final String? category;
  final bool isWishlisted;
  final VoidCallback? onTap;
  final VoidCallback? onWishlistToggle;
  final bool showBadge;
  final String? badgeText;
  final Color? badgeColor;

  const ListingCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.location,
    required this.condition,
    this.category,
    this.isWishlisted = false,
    this.onTap,
    this.onWishlistToggle,
    this.showBadge = false,
    this.badgeText,
    this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (context, url) => Container(
                      color: theme.colorScheme.surfaceContainerHighest,
                      child: Center(
                        child: Icon(
                          Icons.image_outlined,
                          size: 32.sp,
                          color: theme.colorScheme.outline,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: theme.colorScheme.surfaceContainerHighest,
                      child: Center(
                        child: Icon(
                          Icons.broken_image_outlined,
                          size: 32.sp,
                          color: theme.colorScheme.outline,
                        ),
                      ),
                    ),
                  ),
                ),
                // Condition Badge
                if (showBadge && badgeText != null)
                  Positioned(
                    top: 8.h,
                    left: 8.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: badgeColor ?? theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        badgeText!,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  ),
                // Wishlist Button
                if (onWishlistToggle != null)
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: GestureDetector(
                      onTap: onWishlistToggle,
                      child: Container(
                        padding: EdgeInsets.all(6.r),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.4),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isWishlisted
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: isWishlisted
                              ? Colors.redAccent
                              : Colors.white,
                          size: 18.sp,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            // Content
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category
                  if (category != null) ...[
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        category!,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),
                  ],
                  // Title
                  Text(
                    title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  // Price
                  Text(
                    CurrencyFormatter.format(price),
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),
                  // Condition & Location
                  Row(
                    children: [
                      Icon(
                        Icons.verified_outlined,
                        size: 14.sp,
                        color: theme.colorScheme.outline,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        condition,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.outline,
                        ),
                      ),
                      if (location != null) ...[
                        SizedBox(width: 8.w),
                        Icon(
                          Icons.location_on_outlined,
                          size: 14.sp,
                          color: theme.colorScheme.outline,
                        ),
                        SizedBox(width: 4.w),
                        Flexible(
                          child: Text(
                            location!,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.outline,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListingCardHorizontal extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int price;
  final String? location;
  final String condition;
  final VoidCallback? onTap;

  const ListingCardHorizontal({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.location,
    required this.condition,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                width: 100.w,
                placeholder: (context, url) => Container(
                  width: 100.w,
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: Center(
                    child: Icon(
                      Icons.image_outlined,
                      size: 24.sp,
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 100.w,
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: Center(
                    child: Icon(
                      Icons.broken_image_outlined,
                      size: 24.sp,
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(12.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        CurrencyFormatter.format(price),
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 13.sp,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          Icon(
                            Icons.verified_outlined,
                            size: 12.sp,
                            color: theme.colorScheme.outline,
                          ),
                          SizedBox(width: 3.w),
                          Text(
                            condition,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.outline,
                              fontSize: 11.sp,
                            ),
                          ),
                          if (location != null) ...[
                            SizedBox(width: 6.w),
                            Icon(
                              Icons.location_on_outlined,
                              size: 12.sp,
                              color: theme.colorScheme.outline,
                            ),
                            SizedBox(width: 3.w),
                            Flexible(
                              child: Text(
                                location!,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: theme.colorScheme.outline,
                                  fontSize: 11.sp,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
