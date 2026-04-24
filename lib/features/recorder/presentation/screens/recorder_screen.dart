import 'package:flutter/material.dart';

class RecorderScreen extends StatelessWidget {
  const RecorderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Grabador')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.mic, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text('Pantalla de grabador', style: TextStyle(fontSize: 18)),
            Text('Se implementará en la Sección 3',
                style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
