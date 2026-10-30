import 'package:flutter_test/flutter_test.dart';
import 'package:echo_1/main.dart';

void main() {
  testWidgets('EcoNotes basic smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const EcoNotesApp());
    expect(find.text('EcoNotes'), findsOneWidget);
  });
}
