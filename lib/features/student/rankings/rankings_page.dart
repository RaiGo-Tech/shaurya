import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/page_frame.dart';
import '../../../core/widgets/white_card.dart';

class RankingsPage extends StatelessWidget {
  const RankingsPage({super.key});

  @override
  Widget build(BuildContext context) => PageFrame(
    title: 'Your Ranking',
    subtitle: 'Test #06 · National benchmark',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _RankCard('All India Rank', '1,248', 'of 342,680 learners'),
            _RankCard('State Rank', '76', 'of 24,620 learners'),
            _RankCard('District Rank', '8', 'of 1,870 learners'),
            _RankCard('School Rank', '2', 'of 146 learners'),
          ],
        ),
        const SizedBox(height: 28),
        Text(
          'Top performers — Test #06',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 14),
        const _Leaderboard(),
      ],
    ),
  );
}

class _RankCard extends StatelessWidget {
  const _RankCard(this.title, this.rank, this.caption);
  final String title;
  final String rank;
  final String caption;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 220,
    child: WhiteCard(
      title: title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            rank,
            style: const TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w900,
              color: AppColors.navy,
            ),
          ),
          Text(
            caption,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
          ),
        ],
      ),
    ),
  );
}

class _Leaderboard extends StatelessWidget {
  const _Leaderboard();

  static const _entries = [
    _Entry(1, 'Priya Mehta', 'Delhi Public School', 98, true),
    _Entry(2, 'Rohan Kapoor', 'DAV Public School', 97, false),
    _Entry(3, 'Ananya Reddy', 'Kendriya Vidyalaya', 96, false),
    _Entry(4, 'Aarav Sharma', 'Green Valley School', 86, false, highlight: true),
    _Entry(5, 'Kavya Singh', 'St. Mary\'s Academy', 85, false),
  ];

  @override
  Widget build(BuildContext context) => WhiteCard(
    title: 'National leaderboard',
    child: Column(
      children: [
        for (var i = 0; i < _entries.length; i++) ...[
          if (i > 0) const Divider(),
          _LeaderboardRow(entry: _entries[i]),
        ],
      ],
    ),
  );
}

class _Entry {
  const _Entry(this.rank, this.name, this.school, this.score, this.trophy,
      {this.highlight = false});
  final int rank;
  final String name;
  final String school;
  final int score;
  final bool trophy;
  final bool highlight;
}

class _LeaderboardRow extends StatelessWidget {
  const _LeaderboardRow({required this.entry});
  final _Entry entry;

  @override
  Widget build(BuildContext context) {
    final medal = entry.rank == 1
        ? AppColors.orange
        : entry.rank == 2
        ? const Color(0xFF94A3B8)
        : entry.rank == 3
        ? const Color(0xFFCD7F32)
        : null;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: entry.highlight
          ? BoxDecoration(
              color: AppColors.blue.withValues(alpha: .06),
              borderRadius: BorderRadius.circular(10),
            )
          : null,
      child: Row(
        children: [
          SizedBox(
            width: 36,
            child: medal != null
                ? Icon(Icons.emoji_events, color: medal, size: 22)
                : Text(
                    '${entry.rank}',
                    style: const TextStyle(fontWeight: FontWeight.w800),
                    textAlign: TextAlign.center,
                  ),
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            radius: 18,
            backgroundColor: entry.highlight
                ? AppColors.blue.withValues(alpha: .15)
                : AppColors.sky,
            child: Text(
              entry.name.split(' ').map((w) => w[0]).take(2).join(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: entry.highlight ? AppColors.blue : AppColors.navy,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      entry.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: entry.highlight ? AppColors.blue : null,
                      ),
                    ),
                    if (entry.highlight) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'You',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                Text(
                  entry.school,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            '${entry.score}',
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 16,
              color: AppColors.navy,
            ),
          ),
        ],
      ),
    );
  }
}
