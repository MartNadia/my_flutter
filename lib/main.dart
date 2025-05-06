// main.dart
import 'package:flutter/material.dart';
import 'package:first_flutter/counter.dart';
import 'package:first_flutter/drawing.dart';
import 'package:first_flutter/images.dart';
import 'package:first_flutter/structure.dart';
/*import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://whzhdvsskczfcpngekuz.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndoemhkdnNza2N6ZmNwbmdla3V6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU2NTA1MTYsImV4cCI6MjA2MTIyNjUxNn0.plZDgS62XS0E1xTC9KuqzCyZuo16bsxSl00WWfqieFI';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supabase SignUp Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _signUp() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final res = await Supabase.instance.client.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (res.session != null) {
        print('Signed up successfully!');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully signed up! Check your email to verify.'))
        );
      } else {
        print('Error signing up: ${res.user?.email}');
        setState(() {
          _errorMessage = 'Error signing up.  Please check your email and password.';
        });
      }

    } on AuthException catch (e) {
      print('AuthException: ${e.message}');
      setState(() {
        _errorMessage = e.message;
      });
    } catch (e) {
      print('Unexpected error: $e');
      setState(() {
        _errorMessage = 'An unexpected error occurred.  Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supabase Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isLoading ? null : _signUp,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}*/

void main() {
  runApp(const MyApp());
}

mixin AwaitLogger {
  Future<T> loggedAwait<T>(Future<T> future, {String? tag}) async {
    debugPrint('⌛ [Await Start] $tag');
    final result = await future;
    debugPrint('✅ [Await End] $tag');
    return result;
  }
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
      },
    );
  }
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

/*class MyApp extends StatelessWidget {
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
}*/
