import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';
import "dart:ui" as ui;

import 'package:image_cropper/image_cropper.dart';

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
      home: const SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 800),
          pageBuilder: (_, _, _) => const HomePage(),
          transitionsBuilder: (_, animation, _, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.auto_awesome, size: 72, color: Colors.white),
            SizedBox(height: 16),
            Text(
              'Tığ İşi Pattern Üretici',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
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

  Future<String?> _validateImage(XFile file) async {
    final ext = file.path.split(".").last.toLowerCase();
    if (!["jpg", "jpeg", "png"].contains(ext)) {
      return "Lütfen jpg, jpeg veya png formatında bir fotoğraf seçin.";
    }
    final bytes = await file.readAsBytes();
    if (bytes.length > 10 * 1024 * 1024) {
      return "Lütfen 10MB'den küçük bir fotoğraf seçin.";
    }
    try {
      final codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();
      final w = frame.image.width;
      final h = frame.image.height;
      frame.image.dispose();
      codec.dispose();
      if (w < 300 || h < 300) {
        return "Lütfen en az 300x300 piksel boyutunda bir fotoğraf seçin.";
      }
    } catch (_) {
      return "fotoğraf okunamadı.";
    }
    return null;
  }

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );
    if (picked == null) return;
    final error = await _validateImage(picked);
    if (!mounted) return;
    if (error != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error)));
      return;
    }
    final cropped = await ImageCropper().cropImage(
      sourcePath: picked.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Fotoğrafı kırp',
          lockAspectRatio: true,
        ),
      ],
    );
    if (cropped == null) return;
    setState(() {
      _image = XFile(cropped.path);
    });
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
