// main.dart
import 'supabase.dart';
import 'package:flutter/material.dart';
import 'counter.dart';
import 'drawing.dart';
import 'images.dart';
import 'structure.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Приложение',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Counter(),
        '/structure': (context) => const Structura(),
        '/images': (context) => const ImageExamples(),
        '/drawing': (context) => const PainterPage(),
        '/supabase': (context) => const SignUpScreen(),
      },
    );
  }
}
