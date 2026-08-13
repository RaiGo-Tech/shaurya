import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class TestAttemptPage extends StatefulWidget {
  const TestAttemptPage({super.key});

  @override
  State<TestAttemptPage> createState() => _TestAttemptPageState();
}

class _TestAttemptPageState extends State<TestAttemptPage> {
  final Map<int, int> _answers = {};
  final Set<int> _marked = {};
  int _current = 0;
  bool _submitting = false;

  static const _totalSeconds = 90 * 60;
  late int _secondsLeft;
  Timer? _timer;

  static const _questions = [
    _Question('What fraction represents 3 shaded parts from 8 equal parts?', [
      '3/8',
      '5/8',
      '3/5',
      '8/3',
    ], 0),
    _Question('Which is a renewable source of energy?', [
      'Coal',
      'Natural gas',
      'Solar energy',
      'Petroleum',
    ], 2),
    _Question('The value of 25% of 240 is:', ['40', '50', '60', '75'], 2),
    _Question('Which organ pumps blood throughout the body?', [
      'Lungs',
      'Brain',
      'Heart',
      'Kidneys',
    ], 2),
    _Question('What is the SI unit of force?', [
      'Joule',
      'Newton',
      'Watt',
      'Pascal',
    ], 1),
    _Question('Solve: 2x + 5 = 15', ['x = 5', 'x = 10', 'x = 7', 'x = 3'], 0),
  ];

  @override
  void initState() {
    super.initState();
    _secondsLeft = _totalSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_secondsLeft <= 0) {
        _timer?.cancel();
        _submit(auto: true);
        return;
      }
      setState(() => _secondsLeft--);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _timeLabel {
    final m = (_secondsLeft ~/ 60).toString().padLeft(2, '0');
    final s = (_secondsLeft % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  Future<void> _submit({bool auto = false}) async {
    if (_submitting) return;
    if (!auto) {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Submit test?'),
          content: Text(
            'You have answered ${_answers.length}/${_questions.length} questions.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Continue'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Submit'),
            ),
          ],
        ),
      );
      if (confirmed != true) return;
    }
    setState(() => _submitting = true);
    _timer?.cancel();
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    final score = _questions.asMap().entries
        .where((e) => _answers[e.key] == e.value.correct)
        .length;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => TestResultPage(
          score: score,
          total: _questions.length,
          marked: _marked.length,
        ),
      ),
    );
  }

  void _showPalette() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question palette',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(
                _questions.length,
                (i) => _PaletteDot(
                  index: i,
                  current: _current,
                  answered: _answers.containsKey(i),
                  marked: _marked.contains(i),
                  onTap: () {
                    setState(() => _current = i);
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Answered: ${_answers.length}/${_questions.length}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final q = _questions[_current];
    final wide = MediaQuery.sizeOf(context).width > 760;
    final urgent = _secondsLeft < 300;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test #07 · Science + Mathematics'),
        actions: [
          if (!wide)
            IconButton(
              icon: const Icon(Icons.grid_view_rounded),
              onPressed: _showPalette,
              tooltip: 'Question palette',
            ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: urgent
                      ? Colors.red.withValues(alpha: .1)
                      : AppColors.sky.withValues(alpha: .5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: 16,
                      color: urgent ? Colors.red : AppColors.navy,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _timeLabel,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: urgent ? Colors.red : AppColors.navy,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearProgressIndicator(
                    value: (_current + 1) / _questions.length,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Question ${_current + 1} of ${_questions.length} · Auto-saved',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 28),
                  Text(
                    q.text,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      children: List.generate(
                        q.options.length,
                        (i) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _OptionTile(
                            label: q.options[i],
                            letter: String.fromCharCode(65 + i),
                            selected: _answers[_current] == i,
                            onTap: () => setState(() => _answers[_current] = i),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: _current == 0
                            ? null
                            : () => setState(() => _current--),
                        child: const Text('Previous'),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton.icon(
                        onPressed: () => setState(
                          () => _marked.contains(_current)
                              ? _marked.remove(_current)
                              : _marked.add(_current),
                        ),
                        icon: Icon(
                          _marked.contains(_current)
                              ? Icons.bookmark
                              : Icons.bookmark_outline,
                        ),
                        label: Text(
                          _marked.contains(_current)
                              ? 'Marked'
                              : 'Mark for review',
                        ),
                      ),
                      const Spacer(),
                      FilledButton(
                        onPressed: _current == _questions.length - 1
                            ? () => _submit()
                            : () => setState(() => _current++),
                        child: Text(
                          _current == _questions.length - 1
                              ? (_submitting ? 'Submitting...' : 'Submit test')
                              : 'Save & Next',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (wide) _SidePalette(
            count: _questions.length,
            current: _current,
            answers: _answers,
            marked: _marked,
            onSelect: (i) => setState(() => _current = i),
          ),
        ],
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.label,
    required this.letter,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String letter;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: selected
        ? AppColors.blue.withValues(alpha: .08)
        : Theme.of(context).cardTheme.color,
    borderRadius: BorderRadius.circular(12),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? AppColors.blue : AppColors.border,
            width: selected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 13,
              backgroundColor: selected ? AppColors.blue : AppColors.sky,
              child: Text(
                letter,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: selected ? Colors.white : AppColors.navy,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(label)),
          ],
        ),
      ),
    ),
  );
}

class _SidePalette extends StatelessWidget {
  const _SidePalette({
    required this.count,
    required this.current,
    required this.answers,
    required this.marked,
    required this.onSelect,
  });

  final int count;
  final int current;
  final Map<int, int> answers;
  final Set<int> marked;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) => Container(
    width: 235,
    color: AppColors.sky.withValues(
      alpha: Theme.of(context).brightness == Brightness.dark ? .08 : 1,
    ),
    padding: const EdgeInsets.all(22),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Question palette',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(
            count,
            (i) => _PaletteDot(
              index: i,
              current: current,
              answered: answers.containsKey(i),
              marked: marked.contains(i),
              onTap: () => onSelect(i),
            ),
          ),
        ),
        const Spacer(),
        _Legend(),
        const SizedBox(height: 12),
        Text(
          'Answered: ${answers.length}/$count',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    ),
  );
}

class _PaletteDot extends StatelessWidget {
  const _PaletteDot({
    required this.index,
    required this.current,
    required this.answered,
    required this.marked,
    required this.onTap,
  });

  final int index;
  final int current;
  final bool answered;
  final bool marked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    if (index == current) {
      bg = AppColors.blue;
      fg = Colors.white;
    } else if (marked) {
      bg = AppColors.orange;
      fg = Colors.white;
    } else if (answered) {
      bg = AppColors.green;
      fg = Colors.white;
    } else {
      bg = Theme.of(context).cardTheme.color ?? Colors.white;
      fg = Theme.of(context).colorScheme.onSurface;
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: CircleAvatar(
        backgroundColor: bg,
        foregroundColor: fg,
        radius: 18,
        child: Text('${index + 1}'),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _LegendItem(AppColors.green, 'Answered'),
      const SizedBox(height: 6),
      _LegendItem(AppColors.orange, 'Marked'),
      const SizedBox(height: 6),
      _LegendItem(AppColors.blue, 'Current'),
    ],
  );
}

class _LegendItem extends StatelessWidget {
  const _LegendItem(this.color, this.label);
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      const SizedBox(width: 8),
      Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 11)),
    ],
  );
}

class TestResultPage extends StatelessWidget {
  const TestResultPage({
    super.key,
    required this.score,
    required this.total,
    required this.marked,
  });

  final int score;
  final int total;
  final int marked;

  @override
  Widget build(BuildContext context) {
    final pct = (score / total * 100).round();
    return Scaffold(
      appBar: AppBar(title: const Text('Test submitted')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: AppColors.green.withValues(alpha: .12),
                      child: const Icon(
                        Icons.task_alt_rounded,
                        size: 44,
                        color: AppColors.green,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Assessment submitted!',
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Provisional score · Official results after publication',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _ResultStat('$score/$total', 'Score'),
                        _ResultStat('$pct%', 'Accuracy'),
                        _ResultStat('$marked', 'Marked'),
                      ],
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () =>
                            Navigator.of(context).popUntil((r) => r.isFirst),
                        child: const Text('Back to dashboard'),
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

class _ResultStat extends StatelessWidget {
  const _ResultStat(this.value, this.label);
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(
        value,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: AppColors.navy,
        ),
      ),
      Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12)),
    ],
  );
}

class _Question {
  const _Question(this.text, this.options, this.correct);
  final String text;
  final List<String> options;
  final int correct;
}
