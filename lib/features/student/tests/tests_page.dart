import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/page_frame.dart';
import '../../../core/widgets/white_card.dart';
import '../../tests/presentation/test_attempt_page.dart';

class TestsPage extends StatelessWidget {
  const TestsPage({super.key});

  @override
  Widget build(BuildContext context) => PageFrame(
    title: 'National Tests',
    subtitle: 'Your official assessments for Academic Year 2026–27.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WhiteCard(
          title: 'Upcoming',
          child: TestTile(
            title: 'Test #07 · Science + Mathematics',
            date: '15 August 2026 · 10:00 AM',
            status: 'Start assessment',
            highlight: true,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const TestAttemptPage()),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Previous tests',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 10),
        const WhiteCard(
          title: '',
          child: Column(
            children: [
              TestTile(
                title: 'Test #06 · Mathematics',
                date: 'Result published · Score 86/100',
                status: 'View result',
                score: 86,
              ),
              Divider(),
              TestTile(
                title: 'Test #05 · Science',
                date: 'Result published · Score 78/100',
                status: 'View result',
                score: 78,
              ),
              Divider(),
              TestTile(
                title: 'Test #04 · English',
                date: 'Result published · Score 92/100',
                status: 'View result',
                score: 92,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class TestTile extends StatelessWidget {
  const TestTile({
    super.key,
    required this.title,
    required this.date,
    required this.status,
    this.onPressed,
    this.highlight = false,
    this.score,
  });

  final String title;
  final String date;
  final String status;
  final VoidCallback? onPressed;
  final bool highlight;
  final int? score;

  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: CircleAvatar(
      backgroundColor: highlight
          ? AppColors.blue.withValues(alpha: .15)
          : AppColors.sky.withValues(
              alpha: Theme.of(context).brightness == Brightness.dark ? .2 : 1,
            ),
      child: Icon(
        highlight ? Icons.bolt : Icons.assignment_outlined,
        color: AppColors.blue,
      ),
    ),
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
    subtitle: Text(date),
    trailing: score != null
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ScoreRing(score: score!),
              const SizedBox(width: 8),
              TextButton(onPressed: onPressed, child: Text(status)),
            ],
          )
        : FilledButton.tonal(onPressed: onPressed, child: Text(status)),
  );
}

class _ScoreRing extends StatelessWidget {
  const _ScoreRing({required this.score});
  final int score;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 40,
    height: 40,
    child: Stack(
      alignment: Alignment.center,
      children: [
        CircularProgressIndicator(
          value: score / 100,
          strokeWidth: 3,
          backgroundColor: AppColors.border,
          color: score >= 80 ? AppColors.green : AppColors.orange,
        ),
        Text(
          '$score',
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
        ),
      ],
    ),
  );
}
