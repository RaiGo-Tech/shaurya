import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/page_frame.dart';
import '../../../core/widgets/white_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
    required this.darkMode,
    required this.onDarkModeChanged,
  });

  final bool darkMode;
  final ValueChanged<bool> onDarkModeChanged;

  @override
  Widget build(BuildContext context) => PageFrame(
    title: 'Aarav Sharma',
    subtitle: 'Class 8 · Green Valley School · Haryana',
    child: Column(
      children: [
        WhiteCard(
          title: 'Account',
          child: Column(
            children: [
              const ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(radius: 28, child: Text('AS')),
                title: Text(
                  'Student ID: STU-26-HR-00001245',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Text('Keep your profile and contact details up to date'),
              ),
              const Divider(),
              _ProfileRow(Icons.email_outlined, 'Email', 'aarav.sharma@school.edu'),
              _ProfileRow(Icons.phone_outlined, 'Phone', '+91 98765 43210'),
              _ProfileRow(Icons.location_on_outlined, 'District', 'Gurugram, Haryana'),
            ],
          ),
        ),
        const SizedBox(height: 20),
        WhiteCard(
          title: 'Preferences',
          child: Column(
            children: [
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Dark mode'),
                subtitle: const Text('Easier on the eyes at night'),
                secondary: Icon(
                  darkMode ? Icons.dark_mode : Icons.light_mode,
                  color: AppColors.blue,
                ),
                value: darkMode,
                onChanged: onDarkModeChanged,
              ),
              const Divider(),
              const ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.notifications_outlined),
                title: Text('Notifications'),
                subtitle: Text('Test reminders, results, practice tips'),
                trailing: Icon(Icons.chevron_right),
              ),
              const Divider(),
              const ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.language_outlined),
                title: Text('Language'),
                subtitle: Text('English'),
                trailing: Icon(Icons.chevron_right),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        WhiteCard(
          title: 'Achievements',
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const [
              _Badge('Top 5%', Icons.emoji_events, AppColors.orange),
              _Badge('6 Tests', Icons.assignment_turned_in, AppColors.blue),
              _Badge('Streak 12d', Icons.local_fire_department, AppColors.green),
              _Badge('Fast learner', Icons.bolt, AppColors.navy),
            ],
          ),
        ),
      ],
    ),
  );
}

class _ProfileRow extends StatelessWidget {
  const _ProfileRow(this.icon, this.label, this.value);
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Icon(icon, size: 20, color: AppColors.muted),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12)),
              Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    ),
  );
}

class _Badge extends StatelessWidget {
  const _Badge(this.label, this.icon, this.color);
  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: .1),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withValues(alpha: .2)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 8),
        Text(label, style: TextStyle(fontWeight: FontWeight.w700, color: color)),
      ],
    ),
  );
}
