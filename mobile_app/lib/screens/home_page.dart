import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import 'result_page.dart';

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
      return "Fotoğraf okunamadı.";
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

    if (cropped == null || !mounted) return;

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
      appBar: AppBar(title: const Text('StitchPal')),
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
