import 'package:flutter/material.dart';

class StudentNavItem {
  const StudentNavItem({
    required this.label,
    required this.icon,
    this.aiBadge = false,
  });

  final String label;
  final IconData icon;
  final bool aiBadge;
}

const studentNavItems = [
  StudentNavItem(label: 'Dashboard', icon: Icons.dashboard_rounded),
  StudentNavItem(label: 'My Tests', icon: Icons.assignment_outlined),
  StudentNavItem(label: 'Practice Zone', icon: Icons.bolt_outlined),
  StudentNavItem(label: 'AI Tutor', icon: Icons.psychology_outlined, aiBadge: true),
  StudentNavItem(label: 'Rankings', icon: Icons.emoji_events_outlined),
  StudentNavItem(label: 'Performance', icon: Icons.insights_outlined),
  StudentNavItem(label: 'Subjects', icon: Icons.menu_book_outlined),
  StudentNavItem(label: 'Weak Topics', icon: Icons.track_changes_outlined),
  StudentNavItem(label: 'My Progress', icon: Icons.trending_up_rounded),
  StudentNavItem(label: 'Test Calendar', icon: Icons.calendar_month_outlined),
  StudentNavItem(label: 'Achievements', icon: Icons.military_tech_outlined),
  StudentNavItem(label: 'My Profile', icon: Icons.person_outline_rounded),
];

/// Bottom nav indices mapped to full nav indices.
const mobileBottomNavMap = [0, 1, 2, 3, 11];
