import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class PracticeSetupPage extends StatefulWidget {
  const PracticeSetupPage({super.key, this.subject = 'Mathematics'});
  final String subject;

  @override
  State<PracticeSetupPage> createState() => _PracticeSetupPageState();
}

class _PracticeSetupPageState extends State<PracticeSetupPage> {
  String _chapter = 'Fractions & Decimals';
  String _difficulty = 'Adaptive';
  int _questionCount = 10;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Practice setup')),
    body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFF0F1729)
                : const Color(0xFFF9FBFF),
            Theme.of(context).scaffoldBackgroundColor,
          ],
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.sky.withValues(alpha: .5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.auto_awesome_rounded,
                        color: AppColors.blue,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Build a focused practice set',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Practice is personal. It never affects your official rank.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 28),
                    const _FieldLabel('Subject'),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).inputDecorationTheme.fillColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text(
                        widget.subject,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const _FieldLabel('Chapter'),
                    DropdownButtonFormField<String>(
                      initialValue: _chapter,
                      items: const [
                        'Fractions & Decimals',
                        'Algebraic Expressions',
                        'Comparing Quantities',
                      ]
                          .map(
                            (item) => DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(() => _chapter = value!),
                    ),
                    const SizedBox(height: 20),
                    const _FieldLabel('Difficulty'),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: ['Easy', 'Adaptive', 'Challenge']
                          .map(
                            (value) => ChoiceChip(
                              label: Text(value),
                              selected: _difficulty == value,
                              onSelected: (_) =>
                                  setState(() => _difficulty = value),
                              selectedColor: AppColors.sky,
                              side: BorderSide(
                                color: _difficulty == value
                                    ? AppColors.blue
                                    : AppColors.border,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 22),
                    const _FieldLabel('Number of questions'),
                    SegmentedButton<int>(
                      segments: const [
                        ButtonSegment(value: 5, label: Text('5')),
                        ButtonSegment(value: 10, label: Text('10')),
                        ButtonSegment(value: 15, label: Text('15')),
                      ],
                      selected: {_questionCount},
                      onSelectionChanged: (value) =>
                          setState(() => _questionCount = value.first),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => PracticeSessionPage(
                              subject: widget.subject,
                              chapter: _chapter,
                              count: _questionCount,
                            ),
                          ),
                        ),
                        icon: const Icon(Icons.play_arrow_rounded),
                        label: const Text('Start practice'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.label);
  final String label;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      label,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        color: Color(0xFF344054),
      ),
    ),
  );
}

class PracticeSessionPage extends StatefulWidget {
  const PracticeSessionPage({
    super.key,
    required this.subject,
    required this.chapter,
    required this.count,
  });

  final String subject;
  final String chapter;
  final int count;

  @override
  State<PracticeSessionPage> createState() => _PracticeSessionPageState();
}

class _PracticeSessionPageState extends State<PracticeSessionPage> {
  int _current = 0;
  final Map<int, int> _answers = {};
  int _elapsed = 0;
  Timer? _timer;

  late final List<_PracticeQuestion> _questions;

  @override
  void initState() {
    super.initState();
    _questions = _generateQuestions(widget.chapter, widget.count);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _elapsed++);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  List<_PracticeQuestion> _generateQuestions(String chapter, int count) {
    final pool = switch (chapter) {
      'Algebraic Expressions' => [
        _PracticeQuestion('Simplify: 3x + 2x', ['5x', '6x', '5', '3x2'], 0),
        _PracticeQuestion('Value of x if 2x = 10', ['5', '8', '12', '20'], 0),
        _PracticeQuestion('Expand: 2(x + 3)', ['2x + 6', '2x + 3', 'x + 6', '2x + 5'], 0),
      ],
      'Comparing Quantities' => [
        _PracticeQuestion('Ratio of 2:3 equals?', ['2/3', '3/2', '5/6', '6/5'], 0),
        _PracticeQuestion('50% of 80 is', ['40', '50', '30', '45'], 0),
        _PracticeQuestion('Which is greater: 3/4 or 2/3?', ['3/4', '2/3', 'Equal', 'Cannot tell'], 0),
      ],
      _ => [
        _PracticeQuestion('Convert 0.75 to fraction', ['3/4', '7/5', '1/4', '3/5'], 0),
        _PracticeQuestion('Which is larger: 0.6 or 3/5?', ['Equal', '0.6', '3/5', 'Cannot tell'], 0),
        _PracticeQuestion('1/2 + 1/4 equals', ['3/4', '2/6', '1/3', '2/4'], 0),
        _PracticeQuestion('Decimal form of 2/5', ['0.4', '0.25', '0.5', '0.2'], 0),
      ],
    };
    return List.generate(count, (i) => pool[i % pool.length]);
  }

  String get _timeLabel {
    final m = (_elapsed ~/ 60).toString().padLeft(2, '0');
    final s = (_elapsed % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void _selectAnswer(int option) {
    setState(() => _answers[_current] = option);
  }

  void _next() {
    if (_current == _questions.length - 1) {
      _timer?.cancel();
      final finalCorrect = _questions.asMap().entries
          .where((e) => _answers[e.key] == e.value.correct)
          .length;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => PracticeResultPage(
            correct: finalCorrect,
            total: _questions.length,
            elapsed: _elapsed,
            subject: widget.subject,
          ),
        ),
      );
      return;
    }
    setState(() => _current++);
  }

  @override
  Widget build(BuildContext context) {
    final q = _questions[_current];
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.subject} · ${widget.chapter}'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.timer_outlined, size: 16, color: AppColors.green),
                  const SizedBox(width: 4),
                  Text(
                    _timeLabel,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: (_current + 1) / _questions.length,
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(4),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Question ${_current + 1} of ${_questions.length}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            q.text,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 24),
                          Expanded(
                            child: ListView(
                              children: List.generate(
                                q.options.length,
                                (i) => Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: OutlinedButton(
                                    onPressed: () => _selectAnswer(i),
                                    style: OutlinedButton.styleFrom(
                                      alignment: Alignment.centerLeft,
                                      minimumSize: const Size(double.infinity, 54),
                                      backgroundColor: _answers[_current] == i
                                          ? AppColors.sky.withValues(alpha: .5)
                                          : null,
                                      side: BorderSide(
                                        color: _answers[_current] == i
                                            ? AppColors.blue
                                            : AppColors.border,
                                        width: _answers[_current] == i ? 2 : 1,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          '${String.fromCharCode(65 + i)}.',
                                          style: const TextStyle(fontWeight: FontWeight.w800),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(q.options[i]),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                _answers[_current] == null
                                    ? 'Choose an answer'
                                    : 'Answer selected',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const Spacer(),
                              if (_current > 0)
                                OutlinedButton(
                                  onPressed: () => setState(() => _current--),
                                  child: const Text('Back'),
                                ),
                              const SizedBox(width: 8),
                              FilledButton(
                                onPressed: _answers[_current] == null ? null : _next,
                                child: Text(
                                  _current == _questions.length - 1
                                      ? 'Finish'
                                      : 'Next',
                                ),
                              ),
                            ],
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
      ),
    );
  }
}

class PracticeResultPage extends StatelessWidget {
  const PracticeResultPage({
    super.key,
    required this.correct,
    required this.total,
    required this.elapsed,
    required this.subject,
  });

  final int correct;
  final int total;
  final int elapsed;
  final String subject;

  @override
  Widget build(BuildContext context) {
    final pct = (correct / total * 100).round();
    final m = (elapsed ~/ 60).toString().padLeft(2, '0');
    final s = (elapsed % 60).toString().padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(title: const Text('Practice result')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 34,
                      backgroundColor: AppColors.green.withValues(alpha: .12),
                      child: Icon(
                        pct >= 70
                            ? Icons.workspace_premium_rounded
                            : Icons.trending_up_rounded,
                        size: 38,
                        color: AppColors.green,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      pct >= 70 ? 'Great focused practice!' : 'Keep practicing!',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$subject · Private result · Rank unaffected',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _ResultMetric('$correct / $total', 'Score'),
                        _ResultMetric('$pct%', 'Accuracy'),
                        _ResultMetric('$m:$s', 'Time'),
                      ],
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () =>
                            Navigator.of(context).popUntil((r) => r.isFirst),
                        child: const Text('Back to practice zone'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ResultMetric extends StatelessWidget {
  const _ResultMetric(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(
        value,
        style: const TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.w800,
          color: AppColors.navy,
        ),
      ),
      const SizedBox(height: 4),
      Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12)),
    ],
  );
}

class _PracticeQuestion {
  const _PracticeQuestion(this.text, this.options, this.correct);
  final String text;
  final List<String> options;
  final int correct;
}
