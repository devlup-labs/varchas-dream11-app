import 'package:flutter_test/flutter_test.dart';
import 'package:varchas_dream_11/main.dart';

void main() {
  testWidgets('My test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
  });
}
