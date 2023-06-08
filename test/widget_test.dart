// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:chat_gpt/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Создайте свое приложение и запустите фрейм.
    await tester.pumpWidget(MyApp());

    // Убедитесь, что наш счетчик начинается с 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Нажмите на значок "+" и запустите кадр.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Убедитесь, что наш счетчик увеличился.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
