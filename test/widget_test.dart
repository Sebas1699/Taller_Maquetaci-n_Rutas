import 'package:flutter_test/flutter_test.dart';
import 'package:taller_maquetacion/main.dart';

void main() {
  testWidgets('the app loads the login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Bienvenido de nuevo'), findsOneWidget);
    expect(find.text('Inicia sesión para continuar'), findsOneWidget);
  });
}
