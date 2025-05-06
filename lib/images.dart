import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
  

class ImageExamples extends StatefulWidget {
  const ImageExamples({Key? key}) : super(key: key);

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
}