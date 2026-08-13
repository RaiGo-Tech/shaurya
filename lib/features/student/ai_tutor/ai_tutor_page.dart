import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/page_frame.dart';
import '../../../core/widgets/white_card.dart';

class AiTutorPage extends StatelessWidget {
  const AiTutorPage({super.key});

  @override
  Widget build(BuildContext context) => PageFrame(
    title: 'AI Tutor',
    subtitle: 'Personalized explanations powered by AI — ask anything about your tests.',
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.purple.withValues(alpha: .12),
                AppColors.primary.withValues(alpha: .08),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.purple.withValues(alpha: .2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.purple.withValues(alpha: .15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.psychology, color: AppColors.purple),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shaurya AI',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Your 24/7 learning assistant',
                          style: TextStyle(color: AppColors.muted, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'AI',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Hi Aarav! I noticed you struggled with Fractions in Test #06. '
                'Would you like me to explain the concepts or create a practice set?',
                style: TextStyle(height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        WhiteCard(
          title: 'Suggested prompts',
          child: Column(
            children: [
              _PromptTile('Explain my Test #06 mistakes'),
              const Divider(),
              _PromptTile('Create a practice set for weak topics'),
              const Divider(),
              _PromptTile('How can I improve my Science score?'),
            ],
          ),
        ),
      ],
    ),
  );
}

class _PromptTile extends StatelessWidget {
  const _PromptTile(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: const Icon(Icons.chat_bubble_outline, color: AppColors.primary),
    title: Text(text),
    trailing: const Icon(Icons.arrow_forward_ios, size: 14),
    onTap: () {},
  );
}
