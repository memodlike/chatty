import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class ImageViewerPage extends StatelessWidget {
  final String imageUrl;

  const ImageViewerPage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 40, 6, 102),
        title: const Text("Сгенерированное изображение"),
      ),
      backgroundColor: Color.fromARGB(255, 40, 6, 102),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: InteractiveViewer(
                  child: Image.network(imageUrl),
                ),
              ),
            ),
            const SizedBox(height: 26),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: imageUrl));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                            "URL изображения скопирован в буфер обмена"),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.copy,
                    size: 34,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Копировать",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 34),
                TextButton.icon(
                  onPressed: () {
                    Share.share('Посмотрите на это изображение: $imageUrl');
                  },
                  icon: const Icon(
                    Icons.share,
                    size: 34,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Делиться",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 136)
              ],
            ),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}
