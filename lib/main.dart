import 'package:flutter/material.dart';
import 'package:target/core/injection/injection_container.dart' as di;
import 'package:target/core/routes/app_router.dart';
import 'package:target/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.setupInjection();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Target',
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}
