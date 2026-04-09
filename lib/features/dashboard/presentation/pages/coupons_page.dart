import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/empty_state.dart';

class CouponsPage extends StatelessWidget {
  const CouponsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Kupon Saya'),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: const [
                Tab(text: 'Tersedia'),
                Tab(text: 'Terpakai / Kedaluwarsa'),
              ],
              labelStyle: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _AvailableCoupons(theme: theme),
                  const Center(
                    child: EmptyState(
                      icon: Icons.card_giftcard_outlined,
                      title: 'Tidak Ada Kupon',
                      description: 'Kupon yang telah terpakai atau kedaluwarsa',
                    ),
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

class _AvailableCoupons extends StatelessWidget {
  final ThemeData theme;
  const _AvailableCoupons({required this.theme});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.r),
      children: [
        _CouponCard(
          discount: '20%',
          title: 'Diskon Semua Elektronik',
          description: 'Min. pembelian Rp 500.000',
          validUntil: '31 Jan 2025',
          color: AppColors.primaryBlue,
          theme: theme,
        ),
        SizedBox(height: 12.h),
        _CouponCard(
          discount: 'Rp 50K',
          title: 'Voucher Gratis Ongkir',
          description: 'Berlaku untuk semua wilayah',
          validUntil: '15 Feb 2025',
          color: AppColors.successGreen,
          theme: theme,
        ),
        SizedBox(height: 12.h),
        _CouponCard(
          discount: '15%',
          title: 'Flash Sale Hari Ini',
          description: 'Min. pembelian Rp 200.000',
          validUntil: 'Hari Ini',
          color: AppColors.errorRed,
          theme: theme,
        ),
      ],
    );
  }
}

class _CouponCard extends StatelessWidget {
  final String discount;
  final String title;
  final String description;
  final String validUntil;
  final Color color;
  final ThemeData theme;

  const _CouponCard({
    required this.discount,
    required this.title,
    required this.description,
    required this.validUntil,
    required this.color,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: theme.colorScheme.surface,
        border: Border.all(
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          // Discount Section
          Container(
            width: 90.w,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                bottomLeft: Radius.circular(16.r),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  discount,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w800,
                    color: color,
                  ),
                ),
                Text(
                  'OFF',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          // Content Section
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(14.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 12.sp,
                        color: theme.colorScheme.onSurface
                            .withValues(alpha: 0.4),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Berlaku hingga $validUntil',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.4),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
