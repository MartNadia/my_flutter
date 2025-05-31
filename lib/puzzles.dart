import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class PuzzlePiece {
  final ui.Image image;
  final Path path;
  final int x;
  final int y;
  bool isTapped;

  PuzzlePiece({
    required this.image,
    required this.path,
    required this.x,
    required this.y,
    this.isTapped = false,
  });
}

class Puzzle extends StatefulWidget {
  final String imageUrl;

  const Puzzle({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  State<Puzzle> createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> {
  List<PuzzlePiece> pieces = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadPuzzle();
  }

  Future<void> loadPuzzle() async {
    try {
      final http.Response response = await http.get(Uri.parse(widget.imageUrl));

      if (response.statusCode == 200) {
        final Uint8List bytes = response.bodyBytes;
        final ui.Codec codec = await ui.instantiateImageCodec(bytes);
        final ui.FrameInfo frameInfo = await codec.getNextFrame();
        ui.Image fullImage = frameInfo.image;

        // Use screen size
        final screenSize = MediaQuery.of(context).size;
        final screenWidth = screenSize.width;
        final screenHeight = screenSize.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top;

        // Determine the number of rows and cols based on screen size and image aspect ratio
        int rows = 3;
        int cols = 3; // You can calculate dynamically if you like. Make sure rows * cols match length of pieces
        double imageAspectRatio = fullImage.width / fullImage.height;
        double screenAspectRatio = screenWidth / screenHeight;

        // Adjust rows and columns to try to fit within the screen. This is a simple example
        // It may need more sophisticated handling based on your use case.
        if(screenAspectRatio > imageAspectRatio){
          cols = 4; // try to fill the available space
        }

        final pieceWidth = screenWidth / cols;
        final pieceHeight = screenHeight / rows;

        List<PuzzlePiece> newPieces = [];
        for (int i = 0; i < rows; i++) {
          for (int j = 0; j < cols; j++) {
            final Path path = createPuzzlePiecePath(pieceWidth, pieceHeight, i, j, rows, cols);
            newPieces.add(
              PuzzlePiece(
                image: fullImage,
                path: path,
                x: j,
                y: i,
                ),
            );
          }
        }

        setState(() {
          pieces = newPieces;
          loading = false;
        });
      } else {
        print('Failed to load image: ${response.statusCode}');
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load image from URL')),
        );
      }
    } catch (e) {
      print('Error loading image: $e');
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error loading image')),
      );
    }
  }

  Path createPuzzlePiecePath(double width, double height, int row, int col, int rows, int cols) {
    final Path path = Path();
    final bumpSize = min(width, height) / 4;

    path.moveTo(0, 0);

    // Top edge
    if (row > 0) {
      path.lineTo(width / 3, 0);
      path.cubicTo(
          width / 3, -bumpSize, 2 * width / 3, -bumpSize, 2 * width / 3, 0);
    }
    path.lineTo(width, 0);

    // Right edge
    if (col < cols - 1) {
      path.lineTo(width, height / 3);
      path.cubicTo(width + bumpSize, height / 3, width + bumpSize, 2 * height / 3, width, 2 * height / 3);
    }
    path.lineTo(width, height);

    // Bottom edge
    if (row < rows - 1) {
      path.lineTo(2 * width / 3, height);
      path.cubicTo(2 * width / 3, height + bumpSize, width / 3, height + bumpSize, width / 3, height);
    }
    path.lineTo(0, height);

    // Left edge
    if (col > 0) {
      path.lineTo(0, 2 * height / 3);
      path.cubicTo(-bumpSize, 2 * height / 3, -bumpSize, height / 3, 0, height / 3);
    }

    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Puzzle')),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(), // Disable scrolling, Important to fit in the screen
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: pieces.isNotEmpty ? (pieces.last.x + 1) : 1,
              childAspectRatio: constraints.maxWidth / constraints.maxHeight,
            ),
            itemCount: pieces.length,
            itemBuilder: (context, index) {
              final piece = pieces[index];
              return GestureDetector(
                onTap: piece.isTapped
                    ? null
                    : () {
                        setState(() {
                          pieces[index].isTapped = true;
                        });
                        print('Tapped puzzle piece at x:${piece.x}, y:${piece.y}');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Tapped piece at (${piece.x}, ${piece.y})')),
                        );
                      },
                child: CustomPaint(
                  painter: PuzzlePiecePainter(piece),
                ),
              );
            },
          );
        }
      ),
    );
  }
}

class PuzzlePiecePainter extends CustomPainter {
  final PuzzlePiece piece;

  PuzzlePiecePainter(this.piece);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(0, 0);
    Path bounds = Path();
    bounds.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.clipPath(piece.path);

    canvas.drawImageRect(
      piece.image,
      Rect.fromLTWH(piece.x * size.width , piece.y* size.height, size.width, size.height),  // Correct image source rect
      Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height)),
      Paint()..color = piece.isTapped ? Colors.grey : Colors.transparent
    );
    canvas.restore();
    if (piece.isTapped) {
      canvas.drawPath(piece.path, Paint()
        ..color = Colors.grey.withOpacity(0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2);
    } else {
      canvas.drawPath(piece.path, Paint()
        ..color = Colors.black.withOpacity(0.2)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: Puzzle(
        imageUrl: 'https://avatars.mds.yandex.net/get-mpic/5288539/img_id7831558020096983321.jpeg/orig',
      ),
    ),
  );
}