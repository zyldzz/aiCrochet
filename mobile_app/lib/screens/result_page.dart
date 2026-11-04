import 'dart:io';

import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key, required this.imagePath});

  final String imagePath;

  // Örnek veri
  static const List<String> _samplePattern = [
    "Sıra 1",
    "Sıra 2",
    "Sıra 3",
    "Sıra 4",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analiz Sonucu')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SizedBox(
            height: 200,
            child: Image.file(File(imagePath), fit: BoxFit.contain),
          ),

          const SizedBox(height: 16),

          Card(
            color: Colors.amber.shade100,
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'Bu ekran örnek/temsili bir sonuçtur. '
                'Gerçek görüntü analizi henüz entegre edilmemiştir; '
                'sonraki haftalarda backend/model entegrasyonu '
                'ile eklenecektir.',
              ),
            ),
          ),

          const SizedBox(height: 16),

          const Text(
            "Örnek pattern",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          for (final row in _samplePattern) ListTile(title: Text(row)),
        ],
      ),
    );
  }
}
