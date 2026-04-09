import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/empty_state.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Notifikasi'),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Tandai Semua Dibaca',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          _NotificationItem(
            icon: Icons.shopping_bag_outlined,
            iconColor: AppColors.primaryBlue,
            title: 'Pesanan Berhasil Dibuat',
            message: 'Pesanan #ORD-20250115 untuk iPhone 14 Pro telah berhasil dibuat.',
            time: '2 menit lalu',
            isUnread: true,
            theme: theme,
            onTap: () => context.push('/dashboard/orders'),
          ),
          SizedBox(height: 8.h),
          _NotificationItem(
            icon: Icons.payment_outlined,
            iconColor: AppColors.successGreen,
            title: 'Pembayaran Diterima',
            message: 'Pembayaran Rp 15.000.000 dari Budi Santoso telah diterima.',
            time: '1 jam lalu',
            isUnread: true,
            theme: theme,
            onTap: () => context.push('/dashboard/wallet'),
          ),
          SizedBox(height: 8.h),
          _NotificationItem(
            icon: Icons.local_shipping_outlined,
            iconColor: AppColors.warningAmber,
            title: 'Pesanan Dikirim',
            message: 'Pesanan #ORD-20250112 telah dikirim via JNE Express.',
            time: '3 jam lalu',
            isUnread: false,
            theme: theme,
            onTap: () {},
          ),
          SizedBox(height: 8.h),
          _NotificationItem(
            icon: Icons.star_outlined,
            iconColor: AppColors.warningAmber,
            title: 'Rating Baru',
            message: 'Andi memberikan rating 5 bintang untuk produk Anda.',
            time: 'Kemarin',
            isUnread: false,
            theme: theme,
            onTap: () {},
          ),
          SizedBox(height: 8.h),
          _NotificationItem(
            icon: Icons.card_giftcard_outlined,
            iconColor: AppColors.errorRed,
            title: 'Promo Spesial!',
            message: 'Dapatkan diskon 20% untuk semua elektronik hari ini!',
            time: '2 hari lalu',
            isUnread: false,
            theme: theme,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String message;
  final String time;
  final bool isUnread;
  final ThemeData theme;
  final VoidCallback onTap;

  const _NotificationItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.message,
    required this.time,
    required this.isUnread,
    required this.theme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(14.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: isUnread
                ? Border.all(
                    color: theme.colorScheme.primary.withValues(alpha: 0.3),
                    width: 1.5,
                  )
                : null,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 20.sp, color: iconColor),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (isUnread) ...[
                          Container(
                            width: 6.w,
                            height: 6.h,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 6.w),
                        ],
                        Expanded(
                          child: Text(
                            title,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: isUnread
                                  ? FontWeight.w700
                                  : FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      message,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface
                            .withValues(alpha: 0.6),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      time,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurface
                            .withValues(alpha: 0.4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
