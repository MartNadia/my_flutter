import 'package:first_flutter/supabase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_flutter/counter.dart';
import 'drawing.dart';
import 'images.dart';
import 'structure.dart';
import 'dart:async';

class TimerModel extends ChangeNotifier {
  Timer? _timer;
  int _secondsElapsed = 0;

  int get secondsElapsed => _secondsElapsed;

  TimerModel(){
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _secondsElapsed++;
      notifyListeners();
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  void resetTimer() {
    stopTimer();
    _secondsElapsed = 0;
    startTimer();
    notifyListeners();
  }

  void incrementCounter(int value) {
    _secondsElapsed += value;
    notifyListeners();
  }
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TimerModel()),
      ],
      child: const MyApp(),
    ),
  );
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
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главный экран'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Таймер
            const Text(
              'Время в приложении:',
              style: TextStyle(fontSize: 20),
            ),
            Consumer<TimerModel>(
              builder: (context, timerModel, child) {
                return Text(
                  '${timerModel.secondsElapsed} секунд',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<TimerModel>(context, listen: false).resetTimer();
              },
              child: const Text('Сбросить таймер'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Counter()),
                );
              },
              child: const Text('Перейти к Counter'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Structura()),
                );
              },
              child: const Text('Перейти к Structura'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ImageExamples()),
                );
              },
              child: const Text('Перейти к ImageExamples'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PainterPage()),
                );
              },
              child: const Text('Перейти к PainterPage'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpScreen()),
                );
              },
              child: const Text('Перейти к SignUpScreen'),
            ),
          ],
        ),
      ),
    );
  }
}
