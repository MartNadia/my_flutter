import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter WebSocket Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white
      ),
      home: const MyHomePage(
        title: 'Flutter WebSocket Home Page',
        socketUrl: 'wss://echo.websocket.org',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final String socketUrl;

  const MyHomePage({Key? key, required this.title, required this.socketUrl})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  late WebSocketChannel _channel;
  List<String> _messages = [];
  int _messageCount = 0;

  @override
  void initState() {
    super.initState();
    _channel = WebSocketChannel.connect(Uri.parse(widget.socketUrl));

    _channel.stream.listen((message) {
      setState(() {
        _messages.add(message);
        _messageCount++;
      });
      print('Received message: $message');
    });
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty &&
        _usernameController.text.isNotEmpty) {
      final username = _usernameController.text;
      final message = _messageController.text;
      final formattedMessage = '$username: $message';

      _channel.sink.add(formattedMessage);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Message Count: $_messageCount'),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Enter your username:'),
            ),
            TextField(
              controller: _messageController,
              decoration: const InputDecoration(labelText: 'Enter your message:'),
            ),
            ElevatedButton(
              onPressed: _sendMessage,
              child: const Text('Send Message'),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return Text(_messages[index]);
                },
              ),
            ),
          ],
        ),
      ),
      );
  }
}