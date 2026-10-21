import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

void main() {
  runApp(const CrochetApp());
}

class CrochetApp extends StatelessWidget {
  const CrochetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Crochet App",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 48, 120, 255),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = picked;
      });
    }
  }

  void _clearImage() {
    setState(() {
      _image = null;
    });
  }

  void _startAnalysis() {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen önce bir fotoğraf seçin.')),
      );
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ResultPage(imagePath: _image!.path),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = _image != null;

    return Scaffold(
      appBar: AppBar(title: const Text('Tığ İşi Pattern Üretici')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 250,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 164, 16, 16),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.antiAlias,
                child: hasImage
                    ? Image.file(File(_image!.path), fit: BoxFit.contain)
                    : const Center(child: Text('Henüz fotoğraf seçilmedi')),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text(
                hasImage ? 'Farklı fotoğraf seç' : 'Galeriden fotoğraf seç',
              ),
            ),
            const SizedBox(height: 4),
            if (hasImage)
              ElevatedButton(
                onPressed: _clearImage,
                child: const Text('Fotoğrafı Temizle'),
              ),
            FilledButton(
              onPressed: _startAnalysis,
              child: const Text('Analizi Başlat'),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  const ResultPage({super.key, required this.imagePath});
  final String imagePath;
  //Örnek veri
  static const List<String> _samplePattern = [
    "Sıra1",
    "Sıra2",
    "Sıra3",
    "Sıra4",
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
                'Bu ekran örnek/temsili bir sonuçtur. Gerçek görüntü analizi '
                'henüz entegre edilmemiştir; sonraki haftalarda '
                'backend/model entegrasyonu ile eklenecektir.',
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
