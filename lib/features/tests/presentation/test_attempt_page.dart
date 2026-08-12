import 'package:flutter/material.dart';

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

  static const _questions = [
    _Question('What fraction represents 3 shaded parts from 8 equal parts?', [
      '3/8',
      '5/8',
      '3/5',
      '8/3',
    ]),
    _Question('Which is a renewable source of energy?', [
      'Coal',
      'Natural gas',
      'Solar energy',
      'Petroleum',
    ]),
    _Question('The value of 25% of 240 is:', ['40', '50', '60', '75']),
    _Question('Which organ pumps blood throughout the body?', [
      'Lungs',
      'Brain',
      'Heart',
      'Kidneys',
    ]),
  ];

  Future<void> _submit() async {
    if (_submitting) return;
    setState(() => _submitting = true);
    // The repository will finalize this same idempotency key server-side.
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    setState(() => _submitting = false);
    await showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        icon: const Icon(
          Icons.task_alt_rounded,
          color: Color(0xFF149B6E),
          size: 42,
        ),
        title: const Text('Assessment submitted'),
        content: const Text(
          'Your answers are finalized. Results will appear after official publication.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Back to tests'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final q = _questions[_current];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test #07 · Science + Mathematics'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Center(
              child: Text(
                '01:29:42',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0A2E65),
                ),
              ),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Row(
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
                      'Question ${_current + 1} of ${_questions.length} · Saved locally',
                      style: const TextStyle(color: Color(0xFF667085)),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      q.text,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ...List.generate(
                      q.options.length,
                      (i) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () => setState(() => _answers[_current] = i),
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: _answers[_current] == i
                                  ? const Color(0xFFEAF3FF)
                                  : Colors.white,
                              border: Border.all(
                                color: _answers[_current] == i
                                    ? const Color(0xFF1467D9)
                                    : const Color(0xFFD9E2F0),
                                width: _answers[_current] == i ? 2 : 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 13,
                                  backgroundColor: _answers[_current] == i
                                      ? const Color(0xFF1467D9)
                                      : const Color(0xFFF0F4FA),
                                  child: Text(
                                    String.fromCharCode(65 + i),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF17233A),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(q.options[i]),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
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
                              ? _submit
                              : () => setState(() => _current++),
                          child: Text(
                            _current == _questions.length - 1
                                ? (_submitting
                                      ? 'Submitting...'
                                      : 'Submit test')
                                : 'Save & Next',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (constraints.maxWidth > 760)
              Container(
                width: 235,
                color: const Color(0xFFF0F5FC),
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Question palette',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: List.generate(
                        _questions.length,
                        (i) => InkWell(
                          onTap: () => setState(() => _current = i),
                          child: CircleAvatar(
                            backgroundColor: _current == i
                                ? const Color(0xFF1467D9)
                                : _marked.contains(i)
                                ? const Color(0xFFF79009)
                                : _answers.containsKey(i)
                                ? const Color(0xFF149B6E)
                                : Colors.white,
                            foregroundColor:
                                _current == i ||
                                    _marked.contains(i) ||
                                    _answers.containsKey(i)
                                ? Colors.white
                                : const Color(0xFF17233A),
                            child: Text('${i + 1}'),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Answered: ${_answers.length}/${_questions.length}',
                      style: const TextStyle(color: Color(0xFF667085)),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Question {
  const _Question(this.text, this.options);
  final String text;
  final List<String> options;
}
