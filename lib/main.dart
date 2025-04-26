import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

/*class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Counter App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Counter App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Color _incrementButtonColor = Colors.blue;
  Color _decrementButtonColor = Colors.blue;

  final Duration _colorChangeDuration = const Duration(milliseconds: 200);

  Future<void> _incrementCounter() async {
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
}*/

/*class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Structure Example'),
        ),
        body: Center(
          child: MyStructure(),
        ),
      ),
    );
  }
}

class MyStructure extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
       decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 30,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.black, width: 2)),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: Colors.black, width: 2)),
                  ),
                ),
              ),
              Container(
                width: 80,
                height: 30,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  border: Border(bottom: BorderSide(color: Colors.black, width: 2)),
                ),
              ),
              Expanded(
                child: Container(
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: Colors.black, width: 2)),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Colors.white, 
                    border: Border(bottom: BorderSide(color: Colors.black, width: 2)),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: Colors.black, width: 2)),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: Colors.black, width: 2)),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 30,
                width: 1,
                color: Colors.black,
              ),
               Container(
                height: 30,
                width: 1,
                color: Colors.black,
              ),
                Container(
                height: 30,
                width: 1,
                color: Colors.black,
              ),
               Container(
                height: 30,
                width: 1,
                color: Colors.black,
              ),
                Container(
                height: 30,
                width: 1,
                color: Colors.black,
              ),
            ],
          ),

           Container(
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.red,
               border: Border(bottom: BorderSide(color: Colors.black, width: 2)),
             ),
          ),
           Container(
            height: 30,
             decoration: const BoxDecoration(
               color: Colors.white,
             ),
          ),
        ],
      ),
    );
  }
}*/

/*class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Image Example'),
        ),
        body: const ImageExamples(),
      ),
    );
  }
}

class ImageExamples extends StatefulWidget {
  const ImageExamples({super.key});

  @override
  State<ImageExamples> createState() => _ImageExamplesState();
}

class _ImageExamplesState extends State<ImageExamples> {
  String _dataFromApi = 'Loading...';

  @override
  void initState() {
    super.initState();
    _fetchDataFromApi();
  }

  Future<void> _fetchDataFromApi() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        setState(() {
          _dataFromApi = 'Data from API: ${decodedData.toString()}';
        });
      } else {
        setState(() {
          _dataFromApi = 'Failed to load data. Status code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
          _dataFromApi = 'An error occurred: $e';
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Image.asset:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Image.asset('assets/img.jpg'), // Replace with your actual asset path
            const SizedBox(height: 24),

            const Text(
              'Image.network:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Image.network(
              'https://avatars.mds.yandex.net/get-mpic/5288539/img_id7831558020096983321.jpeg/orig',
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                return const Text('Failed to load image');
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'Data from API:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              _dataFromApi,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}*/


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Painter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PainterPage(),
    );
  }
}

class PainterPage extends StatefulWidget {
  @override
  _PainterPageState createState() => _PainterPageState();
}

class _PainterPageState extends State<PainterPage> {
  List<Offset?> points = [];
  List<Color> colors = [];
  Color currentColor = Colors.black;
  double strokeWidth = 3.0;
  List<Paint> paints = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Painter'),
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              setState(() {
                points.clear();
                colors.clear();
                paints.clear();
              });
            },
          ),
        ],
      ),
      body: GestureDetector(
        onPanStart: (details) {
          setState(() {
            points.add(details.localPosition);
            colors.add(currentColor);
            paints.add(Paint()
              ..color = currentColor
              ..strokeWidth = strokeWidth
              ..strokeCap = StrokeCap.round
              ..style = PaintingStyle.stroke);
          });
        },
        onPanUpdate: (details) {
          setState(() {
            points.add(details.localPosition);
            colors.add(currentColor);
            paints.add(Paint()
              ..color = currentColor
              ..strokeWidth = strokeWidth
              ..strokeCap = StrokeCap.round
              ..style = PaintingStyle.stroke);
          });
        },
        onPanEnd: (details) {
          setState(() {
            points.add(null);
            colors.add(Colors.transparent);
            paints.add(Paint());
          });
        },
        child: CustomPaint(
          painter: SketchPainter(points: points, colors: colors, paints: paints),
          child: Container(
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.color_lens, color: Colors.red),
              onPressed: () {
                setState(() {
                  currentColor = Colors.red;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.color_lens, color: Colors.blue),
              onPressed: () {
                setState(() {
                  currentColor = Colors.blue;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.color_lens, color: Colors.green),
              onPressed: () {
                setState(() {
                  currentColor = Colors.green;
                });
              },
            ),
            Slider(
              value: strokeWidth,
              min: 1.0,
              max: 10.0,
              onChanged: (newValue) {
                setState(() {
                  strokeWidth = newValue;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SketchPainter extends CustomPainter {
  final List<Offset?> points;
  final List<Color> colors;
  final List<Paint> paints; 

  SketchPainter({required this.points, required this.colors, required this.paints});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paints[i]);
      }
    }
  }

  @override
  bool shouldRepaint(covariant SketchPainter oldDelegate) {
    return true;
  }
}
