import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_formatter.dart';

class AiCreditScorePage extends StatelessWidget {
  const AiCreditScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Skor Kredit AI'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Tentang Skor Kredit AI'),
                  content: const Text(
                      'Skor kredit AI merupakan penilaian otomatis berdasarkan riwayat transaksi, kecepatan respon, dan reputasi Anda di platform GCPRUN.'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Mengerti'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          // Score Card
          Card(
            child: Padding(
              padding: EdgeInsets.all(24.r),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.auto_awesome,
                        size: 20.sp,
                        color: AppColors.primaryBlue,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'Skor Kredit AI Anda',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  SizedBox(
                    width: 180.w,
                    height: 180.h,
                    child: CustomPaint(
                      painter: _ScoreRingPainter(
                        score: 850,
                        maxScore: 1000,
                        color: AppColors.successGreen,
                        trackColor:
                            theme.colorScheme.surfaceContainerHighest,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '850',
                              style: TextStyle(
                                fontSize: 48.sp,
                                fontWeight: FontWeight.w800,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            Text(
                              'dari 1000',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface
                                    .withValues(alpha: 0.5),
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.successGreen
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Text(
                                'Sangat Baik',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: AppColors.successGreen,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h),

          // Score Breakdown
          Text(
            'Rincian Penilaian',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12.h),
          _ScoreDetailItem(
            title: 'Riwayat Transaksi',
            score: 92,
            color: AppColors.successGreen,
            theme: theme,
          ),
          SizedBox(height: 8.h),
          _ScoreDetailItem(
            title: 'Kecepatan Respon',
            score: 88,
            color: AppColors.primaryBlue,
            theme: theme,
          ),
          SizedBox(height: 8.h),
          _ScoreDetailItem(
            title: 'Reputasi & Rating',
            score: 95,
            color: AppColors.successGreen,
            theme: theme,
          ),
          SizedBox(height: 8.h),
          _ScoreDetailItem(
            title: 'Verifikasi Identitas',
            score: 70,
            color: AppColors.warningAmber,
            theme: theme,
          ),
          SizedBox(height: 24.h),

          // Score History Chart
          Text(
            'Riwayat Skor',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12.h),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: SizedBox(
                height: 200.h,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const months = [
                              'Agu', 'Sep', 'Okt', 'Nov', 'Des', 'Jan'
                            ];
                            if (value.toInt() >= 0 &&
                                value.toInt() < months.length) {
                              return Padding(
                                padding: EdgeInsets.only(top: 8.h),
                                child: Text(
                                  months[value.toInt()],
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: theme.colorScheme.onSurface
                                        .withValues(alpha: 0.4),
                                  ),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                          reservedSize: 24,
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: const [
                          FlSpot(0, 720),
                          FlSpot(1, 745),
                          FlSpot(2, 780),
                          FlSpot(3, 810),
                          FlSpot(4, 830),
                          FlSpot(5, 850),
                        ],
                        isCurved: true,
                        color: AppColors.primaryBlue,
                        barWidth: 3,
                        dotData: FlDotData(show: true),
                        belowBarData: BarAreaData(
                          show: true,
                          color: AppColors.primaryBlue.withValues(alpha: 0.1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),

          // Benefits
          Text(
            'Keuntungan Skor Tinggi',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12.h),
          _BenefitCard(
            icon: Icons.trending_up,
            title: 'Prioritas Listing',
            description: 'Listing Anda muncul lebih tinggi di pencarian',
            color: AppColors.primaryBlue,
            theme: theme,
          ),
          SizedBox(height: 8.h),
          _BenefitCard(
            icon: Icons.percent,
            title: 'Biaya Transaksi Lebih Rendah',
            description: 'Diskon biaya platform hingga 30%',
            color: AppColors.successGreen,
            theme: theme,
          ),
          SizedBox(height: 8.h),
          _BenefitCard(
            icon: '₿' as IconData,
            title: 'Limit Tarik Dana Lebih Tinggi',
            description: 'Batas penarikan dana harian yang lebih besar',
            color: AppColors.warningAmber,
            theme: theme,
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}

class _ScoreRingPainter extends CustomPainter {
  final double score;
  final double maxScore;
  final Color color;
  final Color trackColor;

  _ScoreRingPainter({
    required this.score,
    required this.maxScore,
    required this.color,
    required this.trackColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 20) / 2;
    const strokeWidth = 12.0;

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

    final sweepAngle = (score / maxScore) * 2 * pi;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -1.5708,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ScoreRingPainter oldDelegate) {
    return score != oldDelegate.score;
  }
}

class _ScoreDetailItem extends StatelessWidget {
  final String title;
  final int score;
  final Color color;
  final ThemeData theme;

  const _ScoreDetailItem({
    required this.title,
    required this.score,
    required this.color,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.r),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  SizedBox(
                    height: 6.h,
                    child: LinearProgressIndicator(
                      value: score / 100,
                      backgroundColor:
                          theme.colorScheme.surfaceContainerHighest,
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              '$score/100',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BenefitCard extends StatelessWidget {
  final dynamic icon;
  final String title;
  final String description;
  final Color color;
  final ThemeData theme;

  const _BenefitCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.r),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: icon is IconData
                  ? Icon(icon as IconData, color: color, size: 20.sp)
                  : Center(
                      child: Text(
                        icon.toString(),
                        style: TextStyle(
                          color: color,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
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
          ],
        ),
      ),
    );
  }
}
