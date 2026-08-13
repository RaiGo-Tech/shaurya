import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class PerformanceLineChart extends StatelessWidget {
  const PerformanceLineChart({super.key});

  static const _scores = [62.0, 68.0, 71.0, 75.0, 79.0, 82.0];

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 180,
    child: LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 20,
          getDrawingHorizontalLine: (_) => FlLine(
            color: AppColors.border,
            strokeWidth: 1,
            dashArray: [4, 4],
          ),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              interval: 20,
              getTitlesWidget: (v, _) => Text(
                '${v.toInt()}',
                style: const TextStyle(fontSize: 10, color: AppColors.muted),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (v, _) {
                final i = v.toInt();
                if (i < 1 || i > 6) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    'Test $i',
                    style: const TextStyle(fontSize: 10, color: AppColors.muted),
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        minY: 40,
        maxY: 100,
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(
              _scores.length,
              (i) => FlSpot((i + 1).toDouble(), _scores[i]),
            ),
            isCurved: true,
            color: AppColors.primary,
            barWidth: 3,
            dotData: FlDotData(
              show: true,
              getDotPainter: (_, __, ___, ____) => FlDotCirclePainter(
                radius: 4,
                color: Colors.white,
                strokeWidth: 2,
                strokeColor: AppColors.primary,
              ),
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.primary.withValues(alpha: .18),
                  AppColors.primary.withValues(alpha: .02),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class ScoreDonutChart extends StatelessWidget {
  const ScoreDonutChart({
    super.key,
    required this.score,
    required this.correct,
    required this.incorrect,
    required this.unattempted,
  });

  final int score;
  final int correct;
  final int incorrect;
  final int unattempted;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 130,
    child: Stack(
      alignment: Alignment.center,
      children: [
        PieChart(
          PieChartData(
            sectionsSpace: 2,
            centerSpaceRadius: 42,
            sections: [
              PieChartSectionData(
                value: correct.toDouble(),
                color: AppColors.green,
                radius: 14,
                showTitle: false,
              ),
              PieChartSectionData(
                value: incorrect.toDouble(),
                color: AppColors.red,
                radius: 14,
                showTitle: false,
              ),
              PieChartSectionData(
                value: unattempted.toDouble(),
                color: AppColors.orange,
                radius: 14,
                showTitle: false,
              ),
            ],
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$score',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: AppColors.ink,
              ),
            ),
            const Text(
              '/100',
              style: TextStyle(fontSize: 11, color: AppColors.muted),
            ),
          ],
        ),
      ],
    ),
  );
}

class SubjectProgressList extends StatelessWidget {
  const SubjectProgressList({super.key});

  static const _subjects = [
    ('Mathematics', 0.87, AppColors.primary),
    ('Science', 0.82, AppColors.green),
    ('English', 0.78, AppColors.purple),
    ('Social Science', 0.75, AppColors.orange),
    ('Hindi', 0.72, AppColors.red),
  ];

  @override
  Widget build(BuildContext context) => Column(
    children: _subjects
        .map(
          (s) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      s.$1,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      '${(s.$2 * 100).round()}%',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                        color: s.$3,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: s.$2,
                    minHeight: 7,
                    backgroundColor: AppColors.border,
                    color: s.$3,
                  ),
                ),
              ],
            ),
          ),
        )
        .toList(),
  );
}
