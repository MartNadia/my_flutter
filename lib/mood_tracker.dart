import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class MoodEntry {
  final DateTime date;
  final int mood;

  MoodEntry({required this.date, required this.mood});
}

class MoodEntryAdapter extends TypeAdapter<MoodEntry> {
  @override
  final int typeId = 0;

  @override
  MoodEntry read(BinaryReader reader) {
    final date = DateTime.fromMillisecondsSinceEpoch(reader.readInt());
    final mood = reader.readInt();
    return MoodEntry(date: date, mood: mood);
  }

  @override
  void write(BinaryWriter writer, MoodEntry obj) {
    writer.writeInt(obj.date.millisecondsSinceEpoch);
    writer.writeInt(obj.mood);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MoodEntryAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}

class MoodProvider extends ChangeNotifier {
  List<MoodEntry> _moodEntries = [];

  List<MoodEntry> get moodEntries => _moodEntries;

  Future<void> loadMoodEntries() async {
    final box = await Hive.openBox<MoodEntry>('moodBox');
    _moodEntries = box.values.toList();
    notifyListeners();
  }

  Future<void> addMoodEntry(DateTime date, int mood) async {
    final box = await Hive.openBox<MoodEntry>('moodBox');
    final newEntry = MoodEntry(date: date, mood: mood);
    await box.add(newEntry);
    _moodEntries.add(newEntry);
    notifyListeners();
  }

  Future<void> clearMoodEntries() async {
    final box = await Hive.openBox<MoodEntry>('moodBox');
    await box.clear();
    _moodEntries.clear();
    notifyListeners();
  }
}

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MoodEntryAdapter());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoodProvider()),
      ],
      child: const MoodTrackerApp(),
    ),
  );
}

class MoodTrackerApp extends StatelessWidget {
  const MoodTrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Tracker',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(98, 167, 214, 246),
        primarySwatch: Colors.blue,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 78, 126, 185),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 78, 126, 185),
        ),
        dialogTheme: const DialogTheme(
          backgroundColor: Color.fromARGB(255, 240, 240, 240),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
      home: const MoodTrackerScreen(),
    );
  }
}

class MoodTrackerScreen extends StatefulWidget {
  const MoodTrackerScreen({Key? key}) : super(key: key);

  @override
  State<MoodTrackerScreen> createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<MoodProvider>(context, listen: false).loadMoodEntries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Tracker'),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<MoodProvider>(context, listen: false).clearMoodEntries();
              },
              icon: Icon(Icons.delete_forever)
          )
        ],
      ),
      body: Consumer<MoodProvider>(
        builder: (context, moodProvider, child) { 
          return ListView.builder(
            itemCount: moodProvider.moodEntries.length,
            itemBuilder: (context, index) {
              final entry = moodProvider.moodEntries[index];
              return MoodTile(entry: entry);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showMoodDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showMoodDialog(BuildContext context) {
    int selectedMood = 1;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('How are you feeling today?'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(Icons.sentiment_very_dissatisfied, color: Colors.red),
                    onPressed: () {
                      selectedMood = 0;
                      Navigator.pop(context);
                      _addMood(selectedMood);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.sentiment_neutral, color: Colors.grey),
                    onPressed: () {
                      selectedMood = 1;
                      Navigator.pop(context);
                      _addMood(selectedMood);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.sentiment_very_satisfied, color: Colors.green),
                    onPressed: () {
                      selectedMood = 2;
                      Navigator.pop(context);
                      _addMood(selectedMood);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _addMood(int mood) {
    Provider.of<MoodProvider>(context, listen: false).addMoodEntry(DateTime.now(), mood);
  }
}

class MoodTile extends StatelessWidget {
  final MoodEntry entry;

  const MoodTile({Key? key, required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color moodColor;
    String moodText;

    switch (entry.mood) {
      case 0:
        moodColor = const Color.fromARGB(255, 255, 25, 8);
        moodText = 'Bad';
        break;
      case 1:
        moodColor = Colors.grey;
        moodText = 'Neutral';
        break;
      case 2:
        moodColor = const Color.fromARGB(255, 55, 233, 61);
        moodText = 'Good';
        break;
      default:
        moodColor = Colors.white;
        moodText = 'Unknown';
    }

    return Card(
      color: moodColor.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(DateFormat('yyyy-MM-dd – kk:mm').format(entry.date)),
            Text(moodText),
          ],
        ),
      ),
    );
  }
}