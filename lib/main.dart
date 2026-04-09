import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/utils/date_formatter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DateFormatter.initialize();

  runApp(
    const ProviderScope(
      child: GCPRUNApp(),
    ),
  );
}
