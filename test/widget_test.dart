import 'package:flutter_test/flutter_test.dart';
import 'package:mathlingo/main.dart';

void main() {
  testWidgets('MathLingo Prototype smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MathLingoApp());
    await tester.pump();

    // Verify MathLingo brand name is present
    expect(find.text('MathLingo'), findsOneWidget);

    // Verify navigation tabs
    expect(find.text('Bản đồ'), findsOneWidget);
    expect(find.text('Hồi phục'), findsOneWidget);
    expect(find.text('Đấu trường'), findsOneWidget);
    expect(find.text('Phụ huynh'), findsOneWidget);
  });
}
