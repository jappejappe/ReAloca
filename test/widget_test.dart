import 'package:flutter_test/flutter_test.dart';
import 'package:ecotroca_escolar/main.dart';

void main() {
  testWidgets('EcoTroca app renders', (WidgetTester tester) async {
    await tester.pumpWidget(const EcoTrocaApp());
    expect(find.text('EcoTroca'), findsOneWidget);
  });
}
