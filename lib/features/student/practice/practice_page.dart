import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/page_frame.dart';
import '../../practice/presentation/practice_setup_page.dart';

class PracticePage extends StatelessWidget {
  const PracticePage({super.key});

  static const _subjects = [
    _Subject('Mathematics', Icons.calculate_outlined, '12 chapters', 68),
    _Subject('Science', Icons.science_outlined, '10 chapters', 54),
    _Subject('English', Icons.menu_book_outlined, '8 chapters', 42),
  ];

  @override
  Widget build(BuildContext context) => PageFrame(
    title: 'Practice Zone',
    subtitle:
        'Practice builds confidence. Official rankings are never affected.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.green.withValues(alpha: .08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.green.withValues(alpha: .2)),
          ),
          child: const Row(
            children: [
              Icon(Icons.shield_outlined, color: AppColors.green),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Practice mode is private — your official rank stays unchanged.',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 18,
          runSpacing: 18,
          children: _subjects
              .map((s) => _PracticeSubjectCard(subject: s))
              .toList(),
        ),
      ],
    ),
  );
}

class _Subject {
  const _Subject(this.name, this.icon, this.info, this.progress);
  final String name;
  final IconData icon;
  final String info;
  final int progress;
}

class _PracticeSubjectCard extends StatelessWidget {
  const _PracticeSubjectCard({required this.subject});
  final _Subject subject;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 260,
    child: Card(
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PracticeSetupPage(subject: subject.name),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(subject.icon, color: AppColors.blue, size: 30),
                  const Spacer(),
                  Text(
                    '${subject.progress}%',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: AppColors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                subject.name,
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
              ),
              Text(subject.info, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: subject.progress / 100,
                  minHeight: 6,
                  backgroundColor: AppColors.border,
                ),
              ),
              const SizedBox(height: 18),
              const Row(
                children: [
                  Text('Choose topic', style: TextStyle(fontWeight: FontWeight.w700)),
                  Spacer(),
                  Icon(Icons.arrow_forward_rounded, size: 18),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
