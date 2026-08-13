import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/widgets/metric_card.dart';
import '../../core/widgets/page_frame.dart';
import '../../core/widgets/white_card.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) => PageFrame(
    title: 'Administration Overview',
    subtitle: 'National platform performance · Live system view',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [
            MetricCard(
              label: 'Total students',
              value: '248,620',
              icon: Icons.groups_outlined,
              color: AppColors.blue,
            ),
            MetricCard(
              label: 'Registered schools',
              value: '1,842',
              icon: Icons.account_balance_outlined,
              color: AppColors.green,
            ),
            MetricCard(
              label: 'Live tests',
              value: '02',
              icon: Icons.bolt_outlined,
              color: AppColors.orange,
            ),
            MetricCard(
              label: 'Total attempts',
              value: '1.4M',
              icon: Icons.assignment_turned_in_outlined,
              color: AppColors.navy,
            ),
          ],
        ),
        const SizedBox(height: 27),
        LayoutBuilder(
          builder: (context, c) => c.maxWidth > 780
              ? const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: _AdminActivity()),
                    SizedBox(width: 20),
                    Expanded(flex: 2, child: _SystemHealth()),
                  ],
                )
              : const Column(
                  children: [
                    _AdminActivity(),
                    SizedBox(height: 20),
                    _SystemHealth(),
                  ],
                ),
        ),
      ],
    ),
  );
}

class _AdminActivity extends StatelessWidget {
  const _AdminActivity();

  @override
  Widget build(BuildContext context) => WhiteCard(
    title: 'Assessment activity',
    child: Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Test #07 participation',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '72%',
              style: TextStyle(
                color: AppColors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const LinearProgressIndicator(
          value: .72,
          minHeight: 10,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        const SizedBox(height: 25),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Submissions in last hour'),
            Text(
              '18,429',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          height: 65,
          decoration: BoxDecoration(
            color: AppColors.sky.withValues(
              alpha: Theme.of(context).brightness == Brightness.dark ? .15 : 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: const Text(
            'Live submission activity',
            style: TextStyle(
              color: AppColors.blue,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
  );
}

class _SystemHealth extends StatelessWidget {
  const _SystemHealth();

  @override
  Widget build(BuildContext context) => WhiteCard(
    title: 'System health',
    child: const Column(
      children: [
        _Health('API availability', '99.99%', AppColors.green),
        Divider(),
        _Health('Queue processing', 'Healthy', AppColors.green),
        Divider(),
        _Health('Background jobs', '12 active', AppColors.blue),
      ],
    ),
  );
}

class _Health extends StatelessWidget {
  const _Health(this.title, this.status, this.color);
  final String title;
  final String status;
  final Color color;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title),
      Text(
        status,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    ],
  );
}

class AdminTable extends StatelessWidget {
  const AdminTable({super.key, required this.title, required this.icon});
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) => PageFrame(
    title: title,
    subtitle: 'Manage and monitor $title across the platform.',
    child: WhiteCard(
      title: '$title directory',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Search $title',
            ),
          ),
          const SizedBox(height: 20),
          const Divider(),
          ...List.generate(
            5,
            (i) => ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.sky.withValues(
                  alpha: Theme.of(context).brightness == Brightness.dark ? .2 : 1,
                ),
                child: Icon(icon, color: AppColors.blue),
              ),
              title: Text('${title.substring(0, title.length - 1)} ${i + 1}'),
              subtitle: const Text('Active · Updated recently'),
              trailing: const Icon(Icons.more_horiz),
            ),
          ),
        ],
      ),
    ),
  );
}
