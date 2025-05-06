import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;
  Color _incrementButtonColor = Colors.blue;
  Color _decrementButtonColor = Colors.blue;
  final Duration _colorChangeDuration = const Duration(milliseconds: 200);

  Future<void> _incrementCounter() async {
    if (!mounted) return;
    setState(() {
      _counter++;
      _incrementButtonColor = Colors.green;
    });
    await Future.delayed(_colorChangeDuration);
    if (mounted) {
      setState(() {
        _incrementButtonColor = Colors.blue;
      });
    }
  }

  Future<void> _decrementCounter() async {
    if (!mounted) return;
    setState(() {
      _counter--;
      _decrementButtonColor = Colors.red;
    });
    await Future.delayed(_colorChangeDuration);
    if (mounted) {
      setState(() {
        _decrementButtonColor = Colors.blue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have changed the counter this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _decrementCounter,
            tooltip: 'Decrement',
            backgroundColor: _decrementButtonColor,
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            backgroundColor: _incrementButtonColor,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}