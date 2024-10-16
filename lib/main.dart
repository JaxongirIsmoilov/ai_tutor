import 'package:ai_tutor/src/core/di/di.dart';
import 'package:ai_tutor/src/core/services/hive_service.dart';
import 'package:ai_tutor/src/features/chat/presentation/bloc/home_bloc.dart';
import 'package:ai_tutor/src/features/chat/presentation/pages/screens/base_screen.dart';
import 'package:ai_tutor/src/features/chat/presentation/pages/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUpDependencies();
  await HiveService.initHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Education App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          bodyLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          displayMedium: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
      home: BlocProvider(
        create: (context) => HomeBloc(),
        child: ChatScreen(),
      ),
    );
  }
}
