import 'package:ai_tutor/src/core/di/di.dart';
import 'package:ai_tutor/src/features/chat/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  setUpDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI tutor',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => HomePage()
      },
    );
  }
}
