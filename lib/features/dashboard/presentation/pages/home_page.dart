import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/widgets/stats_card.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../../../../core/widgets/listing_card.dart';
import '../../data/models/user_model.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final authState = ref.watch(authNotifierProvider);
    final user = authState.user;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await ref.read(authNotifierProvider.notifier).checkAuth();
          },
          child: CustomScrollView(
            slivers: [
              // App Bar
              SliverToBoxAdapter(
                child: _buildHeader(context, theme, user),
              ),

              // Stats Cards
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12.h,
                    crossAxisSpacing: 12.w,
                    childAspectRatio: 1.6,
                  ),
                  delegate: SliverChildListDelegate([
                    StatsCard(
                      icon: Icons.account_balance_wallet_outlined,
                      value: CurrencyFormatter.formatCompact(1250000),
                      label: 'Saldo Dompet',
                      color: AppColors.primaryBlue,
                      onTap: () => context.push('/dashboard/wallet'),
                    ),
                    StatsCard(
                      icon: Icons.star_outline,
                      value: '850',
                      label: 'Skor Kredit AI',
                      color: AppColors.successGreen,
                      onTap: () => context.push('/dashboard/ai-credit-score'),
                    ),
                    StatsCard(
                      icon: Icons.inventory_2_outlined,
                      value: '12',
                      label: 'Total Listing',
                      color: AppColors.warningAmber,
                      onTap: () => context.push('/dashboard/listings'),
                    ),
                    StatsCard(
                      icon: Icons.receipt_long_outlined,
                      value: '5',
                      label: 'Pesanan Aktif',
                      color: AppColors.errorRed,
                      onTap: () => context.push('/dashboard/orders'),
                    ),
                  ]),
                ),
              ),

              // Quick Actions
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: _buildQuickActions(context, theme),
                ),
              ),

              // AI Credit Score Preview
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: _buildCreditScorePreview(context, theme),
                ),
              ),

              SizedBox(height: 24.h),

              // Recent Transactions
              SliverToBoxAdapter(
                child: _buildSectionHeader(
                  theme,
                  title: 'Transaksi Terbaru',
                  action: 'Lihat Semua',
                  onTap: () => context.push('/dashboard/wallet'),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _TransactionTile(
                      icon: Icons.arrow_downward,
                      iconColor: AppColors.successGreen,
                      title: 'Pembayaran dari Andi',
                      subtitle: '15 Jan 2025, 14:30',
                      amount: CurrencyFormatter.format(350000),
                      isPositive: true,
                      theme: theme,
                    ),
                    childCount: 3,
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              // Recent Orders
              SliverToBoxAdapter(
                child: _buildSectionHeader(
                  theme,
                  title: 'Pesanan Terbaru',
                  action: 'Lihat Semua',
                  onTap: () => context.push('/dashboard/orders'),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _OrderTile(
                      title: _orderTitles[index],
                      status: _orderStatuses[index],
                      price: _orderPrices[index],
                      theme: theme,
                      onTap: () {},
                    ),
                    childCount: 3,
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              // Recommendations
              SliverToBoxAdapter(
                child: _buildSectionHeader(
                  theme,
                  title: 'Rekomendasi Untukmu',
                  action: 'Lihat Semua',
                  onTap: () => context.push('/marketplace'),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: SliverToBoxAdapter(
                  child: SizedBox(
                    height: 260.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      separatorBuilder: (_, __) => SizedBox(width: 12.w),
                      itemBuilder: (context, index) => SizedBox(
                        width: 160.w,
                        child: ListingCard(
                          imageUrl: 'https://picsum.photos/seed/listing$index/400/400',
                          title: _listingTitles[index % _listingTitles.length],
                          price: _listingPrices[index % _listingPrices.length],
                          condition: 'Baru',
                          location: _listingLocations[index % _listingLocations.length],
                          category: _listingCategories[index % _listingCategories.length],
                          onTap: () => context.push('/listing/$index'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeData theme, UserModel? user) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
      child: Row(
        children: [
          // Avatar
          GestureDetector(
            onTap: () => context.push('/dashboard/profile'),
            child: Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.primaryGradient,
              ),
              child: Center(
                child: Text(
                  user?.initials ?? 'GC',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          // Greeting
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Halo, ${user?.name.split(' ').first ?? 'Pengguna'}! 👋',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Selamat datang kembali di GCPRUN',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
          // Notification Button
          GestureDetector(
            onTap: () => context.push('/dashboard/notifications'),
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Badge(
                backgroundColor: AppColors.errorRed,
                smallSize: 8,
                child: Icon(
                  Icons.notifications_outlined,
                  size: 20.sp,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          // Search Button
          GestureDetector(
            onTap: () => context.push('/marketplace'),
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.search,
                size: 20.sp,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context, ThemeData theme) {
    final actions = [
      _QuickAction(
        icon: Icons.add_circle_outline,
        label: 'Jual',
        color: AppColors.primaryBlue,
        onTap: () => context.push('/listing/create'),
      ),
      _QuickAction(
        icon: Icons.qr_code_scanner,
        label: 'Scan',
        color: AppColors.successGreen,
        onTap: () {},
      ),
      _QuickAction(
        icon: Icons.card_giftcard,
        label: 'Kupon',
        color: AppColors.warningAmber,
        onTap: () => context.push('/dashboard/coupons'),
      ),
      _QuickAction(
        icon: Icons.headset_mic_outlined,
        label: 'Bantuan',
        color: AppColors.errorRed,
        onTap: () => context.push('/dashboard/support'),
      ),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: actions.map((action) {
        return GestureDetector(
          onTap: action.onTap,
          child: Column(
            children: [
              Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  color: action.color.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  action.icon,
                  size: 22.sp,
                  color: action.color,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                action.label,
                style: theme.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCreditScorePreview(BuildContext context, ThemeData theme) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.auto_awesome,
                        size: 18.sp,
                        color: AppColors.primaryBlue,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'Skor Kredit AI',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Berdasarkan riwayat transaksi Anda',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    height: 6.h,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: 0.85,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: AppColors.successGradient,
                          borderRadius: BorderRadius.circular(3.r),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Skor Anda: 850 / 1000 - Sangat Baik',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: AppColors.successGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            SizedBox(
              width: 80.w,
              height: 80.h,
              child: CustomPaint(
                painter: _CircularScorePainter(
                  score: 850,
                  maxScore: 1000,
                  color: AppColors.successGreen,
                  trackColor: theme.colorScheme.surfaceContainerHighest,
                ),
                child: Center(
                  child: Text(
                    '850',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    ThemeData theme, {
    required String title,
    required String action,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              action,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickAction {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
}

class _TransactionTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String amount;
  final bool isPositive;
  final ThemeData theme;

  const _TransactionTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.isPositive,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20.sp, color: iconColor),
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
      trailing: Text(
        (isPositive ? '+' : '-') + amount,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: isPositive ? AppColors.successGreen : AppColors.errorRed,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _OrderTile extends StatelessWidget {
  final String title;
  final String status;
  final String price;
  final ThemeData theme;
  final VoidCallback onTap;

  const _OrderTile({
    required this.title,
    required this.status,
    required this.price,
    required this.theme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (status) {
      case 'Diproses':
        statusColor = AppColors.warningAmber;
        break;
      case 'Dikirim':
        statusColor = AppColors.primaryBlue;
        break;
      case 'Selesai':
        statusColor = AppColors.successGreen;
        break;
      default:
        statusColor = AppColors.neutral400;
    }

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.all(12.r),
          child: Row(
            children: [
              Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.inventory_2_outlined,
                  size: 24.sp,
                  color: theme.colorScheme.outline,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      price,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface
                            .withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  status,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
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

class _CircularScorePainter extends CustomPainter {
  final double score;
  final double maxScore;
  final Color color;
  final Color trackColor;

  _CircularScorePainter({
    required this.score,
    required this.maxScore,
    required this.color,
    required this.trackColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 8) / 2;
    const strokeWidth = 6.0;

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    final sweepAngle = (score / maxScore) * 2 * 3.14159265359;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -1.5708, // -90 degrees (start from top)
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircularScorePainter oldDelegate) {
    return score != oldDelegate.score;
  }
}

// Sample data
const _orderTitles = [
  'iPhone 15 Pro Max 256GB',
  'MacBook Air M2 2024',
  'Sony WH-1000XM5',
];

const _orderStatuses = ['Diproses', 'Dikirim', 'Selesai'];

const _orderPrices = [
  'Rp 22.500.000',
  'Rp 18.750.000',
  'Rp 4.200.000',
];

const _listingTitles = [
  'iPhone 15 Pro Max 256GB',
  'MacBook Air M2',
  'Samsung Galaxy S24',
  'PlayStation 5 Digital',
  'iPad Air M2',
];

const _listingPrices = [
  22500000,
  18750000,
  14200000,
  6800000,
  9500000,
];

const _listingLocations = [
  'Jakarta Selatan',
  'Bandung',
  'Surabaya',
  'Yogyakarta',
  'Semarang',
];

const _listingCategories = [
  'Elektronik',
  'Komputer',
  'Smartphone',
  'Gaming',
  'Elektronik',
];
