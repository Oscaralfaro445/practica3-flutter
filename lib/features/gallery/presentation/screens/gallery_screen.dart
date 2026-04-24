import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Galería')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.photo_library, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text('Pantalla de galería', style: TextStyle(fontSize: 18)),
            Text('Se implementará en la Sección 4',
                style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
