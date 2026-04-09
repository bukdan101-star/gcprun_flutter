import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/empty_state.dart';

class UserProfilePage extends StatelessWidget {
  final String username;

  const UserProfilePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('@$username'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          // Profile Header
          Center(
            child: Column(
              children: [
                Container(
                  width: 80.w,
                  height: 80.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFF2563EB), Color(0xFF7C3AED)],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'AP',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Andi Pratama',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '@$username',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Bergabung sejak Januari 2024',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: Color(0xFF2563EB).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star,
                              size: 14.sp, color: Color(0xFFF59E0B)),
                          SizedBox(width: 4.w),
                          Text(
                            '4.9',
                            style: theme.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            '(128 ulasan)',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurface
                                  .withValues(alpha: 0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 140.w,
                      height: 40.h,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Follow'),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    SizedBox(
                      width: 140.w,
                      height: 40.h,
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.chat_bubble_outline, size: 18),
                        label: const Text('Chat'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Stats
          Row(
            children: [
              Expanded(
                child: _UserStat(
                  value: '45',
                  label: 'Listing',
                  theme: theme,
                ),
              ),
              Expanded(
                child: _UserStat(
                  value: '312',
                  label: 'Terjual',
                  theme: theme,
                ),
              ),
              Expanded(
                child: _UserStat(
                  value: '98%',
                  label: 'Respon',
                  theme: theme,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Listings
          Text(
            'Listing dari @$username',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12.h),
          const Center(
            child: EmptyState(
              icon: Icons.inventory_2_outlined,
              title: 'Belum Ada Listing',
              description: 'Pengguna ini belum memiliki listing',
            ),
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}

class _UserStat extends StatelessWidget {
  final String value;
  final String label;
  final ThemeData theme;

  const _UserStat({required this.value, required this.label, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.primary,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}
