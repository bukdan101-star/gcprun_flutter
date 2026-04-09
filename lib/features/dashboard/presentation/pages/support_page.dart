import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/empty_state.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Pusat Bantuan'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(Icons.search,
                    size: 20.sp, color: theme.colorScheme.outline),
                SizedBox(width: 10.w),
                Text(
                  'Cari bantuan...',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Quick Actions
          Text(
            'Bantuan Cepat',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _QuickHelp(
                  icon: Icons.receipt_long_outlined,
                  label: 'Pesanan',
                  color: AppColors.primaryBlue,
                  onTap: () {},
                  theme: theme,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _QuickHelp(
                  icon: Icons.payments_outlined,
                  label: 'Pembayaran',
                  color: AppColors.successGreen,
                  onTap: () {},
                  theme: theme,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _QuickHelp(
                  icon: Icons.account_balance_wallet_outlined,
                  label: 'Dompet',
                  color: AppColors.warningAmber,
                  onTap: () {},
                  theme: theme,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // FAQ
          Text(
            'Pertanyaan Umum',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12.h),
          _FaqItem(
            question: 'Bagaimana cara membuat listing?',
            theme: theme,
          ),
          _FaqItem(
            question: 'Bagaimana cara menarik dana?',
            theme: theme,
          ),
          _FaqItem(
            question: 'Bagaimana jika pesanan tidak datang?',
            theme: theme,
          ),
          _FaqItem(
            question: 'Bagaimana cara mengembalikan barang?',
            theme: theme,
          ),
          _FaqItem(
            question: 'Bagaimana cara verifikasi KYC?',
            theme: theme,
          ),
          SizedBox(height: 24.h),

          // Contact
          Text(
            'Hubungi Kami',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12.h),
          Card(
            child: Column(
              children: [
                _ContactTile(
                  icon: Icons.chat_outlined,
                  title: 'Live Chat',
                  subtitle: 'Respons cepat dalam hitungan menit',
                  color: AppColors.primaryBlue,
                  theme: theme,
                  onTap: () {},
                ),
                const Divider(height: 1),
                _ContactTile(
                  icon: Icons.email_outlined,
                  title: 'Email',
                  subtitle: 'support@gcprun.com',
                  color: AppColors.successGreen,
                  theme: theme,
                  onTap: () {},
                ),
                const Divider(height: 1),
                _ContactTile(
                  icon: Icons.phone_outlined,
                  title: 'Telepon',
                  subtitle: '0800-GCPRUN (08:00-17:00)',
                  color: AppColors.warningAmber,
                  theme: theme,
                  onTap: () {},
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

class _QuickHelp extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  final ThemeData theme;

  const _QuickHelp({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 22.sp, color: color),
            ),
            SizedBox(height: 8.h),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FaqItem extends StatefulWidget {
  final String question;
  final ThemeData theme;

  const _FaqItem({required this.question, required this.theme});

  @override
  State<_FaqItem> createState() => _FaqItemState();
}

class _FaqItemState extends State<_FaqItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Theme(
        data: widget.theme.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: 16.w),
          childrenPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
          onExpansionChanged: (expanded) => setState(() => _isExpanded = expanded),
          trailing: Icon(
            _isExpanded ? Icons.expand_less : Icons.expand_more,
            size: 20.sp,
          ),
          title: Text(
            widget.question,
            style: widget.theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          children: [
            Text(
              'Untuk informasi lebih lanjut, silakan hubungi tim dukungan kami melalui live chat atau email. Tim kami siap membantu Anda 24/7.',
              style: widget.theme.textTheme.bodySmall?.copyWith(
                color: widget.theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final ThemeData theme;
  final VoidCallback onTap;

  const _ContactTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.theme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
      leading: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 20.sp),
      ),
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
      trailing: Icon(Icons.chevron_right, color: theme.colorScheme.outline),
      onTap: onTap,
    );
  }
}
