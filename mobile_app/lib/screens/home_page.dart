import 'package:flutter/material.dart';

import '../models/pattern.dart';
import '../services/pattern_loader.dart';
import '../widgets/pattern_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.onCreateTap});

  final VoidCallback onCreateTap;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CrochetPattern> _patterns = [];

  @override
  void initState() {
    super.initState();
    _loadPatterns();
  }

  Future<void> _loadPatterns() async {
    final patterns = await loadSamplePatterns();

    if (!mounted) return;

    setState(() {
      _patterns = patterns;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('StitchPal')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: InkWell(
              onTap: widget.onCreateTap,
              child: const Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  children: [
                    Icon(Icons.add_photo_alternate, size: 48),
                    SizedBox(height: 8),
                    Text(
                      'Yeni pattern oluştur',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text('Tığ işi fotoğrafından pattern üret'),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Örnek patternler',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          for (final p in _patterns)
            PatternCard(pattern: p, isLiked: false, onLikeTap: () {}),
        ],
      ),
    );
  }
}
