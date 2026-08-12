import 'package:flutter_test/flutter_test.dart';
import 'package:shaurya/main.dart';

void main() {
  testWidgets('shows Shaurya student dashboard', (tester) async {
    await tester.pumpWidget(const ShauryaApp());
    expect(find.text('Good morning, Aarav'), findsOneWidget);
    expect(find.text('NEXT ALL INDIA TEST'), findsOneWidget);
  });
}
