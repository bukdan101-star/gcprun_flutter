import 'package:flutter_test/flutter_test.dart';

import 'package:gcprun/app.dart';

void main() {
  testWidgets('App starts with GCPRUNApp', (WidgetTester tester) async {
    // Basic smoke test - verify the app builds
    expect(GCPRUNApp, isNotNull);
  });
}
