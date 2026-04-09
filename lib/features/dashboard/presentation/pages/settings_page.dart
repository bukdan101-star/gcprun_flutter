import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../../shared/providers/theme_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final user = ref.watch(authNotifierProvider).user;
    final themeState = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Pengaturan'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          // Profile Section
          _buildSectionHeader(theme, 'Profil'),
          Card(
            child: Column(
              children: [
                _SettingsTile(
                  icon: Icons.person_outline,
                  title: 'Edit Profil',
                  subtitle: 'Ubah nama, bio, dan foto profil',
                  trailing: Icons.chevron_right,
                  onTap: () => context.push('/dashboard/profile'),
                ),
                const Divider(height: 1),
                _SettingsTile(
                  icon: Icons.lock_outline,
                  title: 'Ubah Password',
                  subtitle: 'Perbarui kata sandi Anda',
                  trailing: Icons.chevron_right,
                  onTap: () {},
                ),
                const Divider(height: 1),
                _SettingsTile(
                  icon: Icons.verified_user_outlined,
                  title: 'Verifikasi KYC',
                  subtitle: user?.kycVerified == true
                      ? 'Terverifikasi'
                      : 'Belum diverifikasi',
                  trailing: Icons.chevron_right,
                  trailingIconColor: user?.kycVerified == true
                      ? AppColors.successGreen
                      : AppColors.warningAmber,
                  onTap: () => context.push('/dashboard/kyc'),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Appearance Section
          _buildSectionHeader(theme, 'Tampilan'),
          Card(
            child: Column(
              children: [
                _SettingsTile(
                  icon: Icons.dark_mode_outlined,
                  title: 'Mode Gelap',
                  subtitle: _getThemeLabel(themeState.mode),
                  trailing: Icons.chevron_right,
                  onTap: () => _showThemePicker(context, ref, themeState),
                ),
                const Divider(height: 1),
                _SettingsTile(
                  icon: Icons.translate_outlined,
                  title: 'Bahasa',
                  subtitle: 'Bahasa Indonesia',
                  trailing: Icons.chevron_right,
                  onTap: () {},
                ),
                const Divider(height: 1),
                _SettingsTile(
                  icon: Icons.text_fields,
                  title: 'Ukuran Font',
                  subtitle: 'Normal',
                  trailing: Icons.chevron_right,
                  onTap: () {},
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Notification Section
          _buildSectionHeader(theme, 'Notifikasi'),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                  secondary: Icon(
                    Icons.notifications_outlined,
                    color: theme.colorScheme.primary,
                  ),
                  title: Text(
                    'Push Notifikasi',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    'Terima notifikasi pesanan dan pesan',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color:
                          theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                  value: true,
                  onChanged: (_) {},
                  activeColor: theme.colorScheme.primary,
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                  secondary: Icon(
                    Icons.email_outlined,
                    color: theme.colorScheme.primary,
                  ),
                  title: Text(
                    'Email Notifikasi',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    'Terima update melalui email',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color:
                          theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                  value: true,
                  onChanged: (_) {},
                  activeColor: theme.colorScheme.primary,
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                  secondary: Icon(
                    Icons.mark_email_unread_outlined,
                    color: theme.colorScheme.primary,
                  ),
                  title: Text(
                    'Promosi',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    'Penawaran dan diskon terbaru',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color:
                          theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                  value: false,
                  onChanged: (_) {},
                  activeColor: theme.colorScheme.primary,
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Security Section
          _buildSectionHeader(theme, 'Keamanan'),
          Card(
            child: Column(
              children: [
                _SettingsTile(
                  icon: Icons.fingerprint,
                  title: 'Autentikasi Biometrik',
                  subtitle: 'Gunakan sidik jari atau Face ID',
                  trailing: Icons.chevron_right,
                  onTap: () {},
                ),
                const Divider(height: 1),
                _SettingsTile(
                  icon: Icons.shield_outlined,
                  title: 'Keamanan Akun',
                  subtitle: 'Aktivitas login dan perangkat',
                  trailing: Icons.chevron_right,
                  onTap: () {},
                ),
                const Divider(height: 1),
                _SettingsTile(
                  icon: Icons.history,
                  title: 'Riwayat Login',
                  subtitle: 'Lihat aktivitas masuk akun',
                  trailing: Icons.chevron_right,
                  onTap: () {},
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Support Section
          _buildSectionHeader(theme, 'Lainnya'),
          Card(
            child: Column(
              children: [
                _SettingsTile(
                  icon: Icons.help_outline,
                  title: 'Pusat Bantuan',
                  subtitle: 'FAQ dan panduan penggunaan',
                  trailing: Icons.chevron_right,
                  onTap: () => context.push('/dashboard/support'),
                ),
                const Divider(height: 1),
                _SettingsTile(
                  icon: Icons.rate_review_outlined,
                  title: 'Beri Rating Aplikasi',
                  subtitle: 'Bagikan pengalaman Anda',
                  trailing: Icons.chevron_right,
                  onTap: () {},
                ),
                const Divider(height: 1),
                _SettingsTile(
                  icon: Icons.info_outline,
                  title: 'Tentang GCPRUN',
                  subtitle: 'Versi 1.0.0',
                  trailing: Icons.chevron_right,
                  onTap: () {
                    showAboutDialog(
                      context: context,
                      applicationName: 'GCPRUN',
                      applicationVersion: '1.0.0',
                      applicationIcon: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            'GC',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      children: [
                        Text(
                          'GCPRUN Marketplace - Platform jual beli terpercaya di Indonesia.',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Logout Button
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: OutlinedButton.icon(
              onPressed: () => _showLogoutDialog(context, ref),
              icon: const Icon(Icons.logout),
              label: const Text('Keluar'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.errorRed,
                side: const BorderSide(color: AppColors.errorRed),
              ),
            ),
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h, left: 4.w),
      child: Text(
        title,
        style: theme.textTheme.labelLarge?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  String _getThemeLabel(ThemeModeOption mode) {
    switch (mode) {
      case ThemeModeOption.light:
        return 'Terang';
      case ThemeModeOption.dark:
        return 'Gelap';
      case ThemeModeOption.system:
        return 'Ikuti Sistem';
    }
  }

  void _showThemePicker(
    BuildContext context,
    WidgetRef ref,
    ThemeModeState themeState,
  ) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pilih Tema',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                SizedBox(height: 16.h),
                _ThemeOption(
                  icon: Icons.light_mode,
                  label: 'Terang',
                  description: 'Latar belakang terang',
                  isSelected: themeState.mode == ThemeModeOption.light,
                  onTap: () {
                    ref
                        .read(themeProvider.notifier)
                        .setThemeMode(ThemeModeOption.light);
                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: 8.h),
                _ThemeOption(
                  icon: Icons.dark_mode,
                  label: 'Gelap',
                  description: 'Latar belakang gelap',
                  isSelected: themeState.mode == ThemeModeOption.dark,
                  onTap: () {
                    ref
                        .read(themeProvider.notifier)
                        .setThemeMode(ThemeModeOption.dark);
                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: 8.h),
                _ThemeOption(
                  icon: Icons.brightness_auto,
                  label: 'Ikuti Sistem',
                  description: 'Menyesuaikan pengaturan perangkat',
                  isSelected: themeState.mode == ThemeModeOption.system,
                  onTap: () {
                    ref
                        .read(themeProvider.notifier)
                        .setThemeMode(ThemeModeOption.system);
                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Keluar dari Akun'),
          content: const Text(
              'Apakah Anda yakin ingin keluar? Anda harus masuk lagi untuk mengakses akun Anda.'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ref.read(authNotifierProvider.notifier).logout();
                context.go('/login');
              },
              style: TextButton.styleFrom(
                foregroundColor: AppColors.errorRed,
              ),
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final IconData trailing;
  final VoidCallback onTap;
  final Color? trailingIconColor;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.onTap,
    this.trailingIconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      leading: Icon(icon, color: theme.colorScheme.primary, size: 22.sp),
      title: Text(
        title,
        style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
        ),
      ),
      trailing: Icon(
        trailing,
        color: trailingIconColor ?? theme.colorScheme.outline,
        size: 20.sp,
      ),
      onTap: onTap,
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.icon,
    required this.label,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.outline.withValues(alpha: 0.2),
          ),
          borderRadius: BorderRadius.circular(12.r),
          color: isSelected
              ? theme.colorScheme.primary.withValues(alpha: 0.05)
              : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24.sp,
              color:
                  isSelected ? theme.colorScheme.primary : theme.colorScheme.outline,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: theme.colorScheme.primary,
                size: 22.sp,
              ),
          ],
        ),
      ),
    );
  }
}
