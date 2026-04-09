import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final user = ref.watch(authNotifierProvider).user;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Profil Saya'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/dashboard/settings'),
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
                  width: 88.w,
                  height: 88.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.primaryGradient,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryBlue.withValues(alpha: 0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      user?.initials ?? 'GC',
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  user?.name ?? 'Pengguna GCPRUN',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (user?.username != null) ...[
                  SizedBox(height: 2.h),
                  Text(
                    '@${user!.username}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ],
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.successGreen.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.verified,
                              size: 14.sp, color: AppColors.successGreen),
                          SizedBox(width: 4.w),
                          Text(
                            user?.isVerified == true ? 'Terverifikasi' : 'Belum Verifikasi',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: AppColors.successGreen,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: user?.kycVerified == true
                            ? AppColors.primaryBlue.withValues(alpha: 0.1)
                            : AppColors.warningAmber.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.badge,
                            size: 14.sp,
                            color: user?.kycVerified == true
                                ? AppColors.primaryBlue
                                : AppColors.warningAmber,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            user?.kycVerified == true ? 'KYC Lengkap' : 'KYC Belum',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: user?.kycVerified == true
                                  ? AppColors.primaryBlue
                                  : AppColors.warningAmber,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: 140.w,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Edit Profil'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Stats Row
          Row(
            children: [
              Expanded(
                child: _StatItem(
                  value: '12',
                  label: 'Listing',
                  theme: theme,
                ),
              ),
              Container(
                width: 1,
                height: 40.h,
                color: theme.colorScheme.outline.withValues(alpha: 0.15),
              ),
              Expanded(
                child: _StatItem(
                  value: '85',
                  label: 'Terjual',
                  theme: theme,
                ),
              ),
              Container(
                width: 1,
                height: 40.h,
                color: theme.colorScheme.outline.withValues(alpha: 0.15),
              ),
              Expanded(
                child: _StatItem(
                  value: '4.8',
                  label: 'Rating',
                  theme: theme,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Bio
          if (user?.bio != null && user!.bio!.isNotEmpty) ...[
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tentang Saya',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      user.bio!,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
          ],

          // Info Cards
          Card(
            child: Column(
              children: [
                _InfoTile(
                  icon: Icons.email_outlined,
                  title: 'Email',
                  value: user?.email ?? '-',
                  theme: theme,
                ),
                const Divider(height: 1),
                _InfoTile(
                  icon: Icons.phone_outlined,
                  title: 'Telepon',
                  value: user?.phone ?? '-',
                  theme: theme,
                ),
                const Divider(height: 1),
                _InfoTile(
                  icon: Icons.location_on_outlined,
                  title: 'Lokasi',
                  value: user?.location ?? '-',
                  theme: theme,
                ),
                const Divider(height: 1),
                _InfoTile(
                  icon: Icons.calendar_today_outlined,
                  title: 'Bergabung',
                  value: user?.createdAt ?? '-',
                  theme: theme,
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Menu Items
          Card(
            child: Column(
              children: [
                _MenuTile(
                  icon: Icons.star_outline,
                  title: 'Skor Kredit AI',
                  theme: theme,
                  onTap: () => context.push('/dashboard/ai-credit-score'),
                ),
                const Divider(height: 1),
                _MenuTile(
                  icon: Icons.card_giftcard_outlined,
                  title: 'Kupon Saya',
                  theme: theme,
                  onTap: () => context.push('/dashboard/coupons'),
                ),
                const Divider(height: 1),
                _MenuTile(
                  icon: Icons.verified_user_outlined,
                  title: 'Verifikasi KYC',
                  theme: theme,
                  onTap: () => context.push('/dashboard/kyc'),
                ),
                const Divider(height: 1),
                _MenuTile(
                  icon: Icons.headset_mic_outlined,
                  title: 'Bantuan',
                  theme: theme,
                  onTap: () => context.push('/dashboard/support'),
                ),
              ],
            ),
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final ThemeData theme;

  const _StatItem({
    required this.value,
    required this.label,
    required this.theme,
  });

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

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final ThemeData theme;

  const _InfoTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
      leading: Icon(icon, size: 20.sp, color: theme.colorScheme.outline),
      title: Text(
        title,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
        ),
      ),
      trailing: Text(
        value,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final ThemeData theme;
  final VoidCallback onTap;

  const _MenuTile({
    required this.icon,
    required this.title,
    required this.theme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
      leading: Icon(icon, color: theme.colorScheme.primary, size: 22.sp),
      title: Text(
        title,
        style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
      trailing: Icon(Icons.chevron_right, color: theme.colorScheme.outline),
      onTap: onTap,
    );
  }
}
