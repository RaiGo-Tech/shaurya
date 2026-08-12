import 'package:flutter/material.dart';

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
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF9FBFF), Color(0xFFF4F7FC)],
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
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.auto_awesome_rounded,
                        color: Color(0xFF155EEF),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Build a focused practice set',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF101828),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Practice is personal. It never affects your official rank.',
                      style: TextStyle(color: Color(0xFF667085)),
                    ),
                    const SizedBox(height: 28),
                    _FieldLabel('Subject'),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F9FC),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE4E7EC)),
                      ),
                      child: Text(
                        widget.subject,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _FieldLabel('Chapter'),
                    DropdownButtonFormField<String>(
                      initialValue: _chapter,
                      items:
                          const [
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
                    _FieldLabel('Difficulty'),
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
                              selectedColor: const Color(0xFFEFF6FF),
                              side: BorderSide(
                                color: _difficulty == value
                                    ? const Color(0xFF155EEF)
                                    : const Color(0xFFE4E7EC),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 22),
                    _FieldLabel('Number of questions'),
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
                            builder: (_) => _PracticeSessionPage(
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

class _PracticeSessionPage extends StatefulWidget {
  const _PracticeSessionPage({
    required this.subject,
    required this.chapter,
    required this.count,
  });
  final String subject, chapter;
  final int count;
  @override
  State<_PracticeSessionPage> createState() => _PracticeSessionPageState();
}

class _PracticeSessionPageState extends State<_PracticeSessionPage> {
  String? _answer;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('${widget.subject} practice'),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: Center(
            child: Text(
              'Untimed',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF039855),
              ),
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
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Question 1',
                    style: TextStyle(
                      color: Color(0xFF667085),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'A ${widget.chapter.toLowerCase()} practice set with ${widget.count} questions is ready.',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ...['Option A', 'Option B', 'Option C', 'Option D'].map(
                    (option) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: OutlinedButton(
                        onPressed: () => setState(() => _answer = option),
                        style: OutlinedButton.styleFrom(
                          alignment: Alignment.centerLeft,
                          minimumSize: const Size(double.infinity, 54),
                          backgroundColor: _answer == option
                              ? const Color(0xFFEFF6FF)
                              : null,
                          side: BorderSide(
                            color: _answer == option
                                ? const Color(0xFF155EEF)
                                : const Color(0xFFB9C9E3),
                            width: _answer == option ? 2 : 1,
                          ),
                        ),
                        child: Text(option),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        _answer == null
                            ? 'Choose an answer to continue'
                            : 'Answer saved',
                        style: const TextStyle(color: Color(0xFF667085)),
                      ),
                      const Spacer(),
                      FilledButton(
                        onPressed: _answer == null
                            ? null
                            : () => Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) => const _PracticeResultPage(),
                                ),
                              ),
                        child: const Text('Finish set'),
                      ),
                    ],
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

class _PracticeResultPage extends StatelessWidget {
  const _PracticeResultPage();
  @override
  Widget build(BuildContext context) => Scaffold(
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
                  const CircleAvatar(
                    radius: 34,
                    backgroundColor: Color(0xFFE7F6EC),
                    child: Icon(
                      Icons.workspace_premium_rounded,
                      size: 38,
                      color: Color(0xFF039855),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Great focused practice!',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Your result is ready. Practice outcomes are private and do not affect official rankings.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF667085)),
                  ),
                  const SizedBox(height: 28),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _ResultMetric('Score', '8 / 10'),
                      _ResultMetric('Accuracy', '80%'),
                      _ResultMetric('Time', '06:42'),
                    ],
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => Navigator.of(
                        context,
                      ).popUntil((route) => route.isFirst),
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

class _ResultMetric extends StatelessWidget {
  const _ResultMetric(this.label, this.value);
  final String label, value;
  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(
        value,
        style: const TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.w800,
          color: Color(0xFF082C5C),
        ),
      ),
      const SizedBox(height: 4),
      Text(
        label,
        style: const TextStyle(color: Color(0xFF667085), fontSize: 12),
      ),
    ],
  );
}
