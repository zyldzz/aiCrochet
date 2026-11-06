import 'package:flutter/material.dart';

import '../models/pattern.dart';

class PatternCard extends StatelessWidget {
  const PatternCard({
    super.key,
    required this.pattern,
    required this.isLiked,
    required this.onLikeTap,
  });

  final CrochetPattern pattern;
  final bool isLiked;
  final VoidCallback onLikeTap;

  static const Map<String, String> _shapeNames = {
    'circle': 'Daire',
    'square': 'Kare',
    'rectangle': 'Dikdörtgen',
    'other': 'Diğer',
  };

  static const Map<String, String> _colorNamesTr = {
    'red': 'Kırmızı',
    'yellow': 'Sarı',
    'blue': 'Mavi',
    'green': 'Yeşil',
  };

  @override
  Widget build(BuildContext context) {
    final shapeText = _shapeNames[pattern.shape] ?? pattern.shape;

    final translatedColors = pattern.colors
        .map((color) => _colorNamesTr[color] ?? color)
        .toList();

    final colorsText = translatedColors.isNotEmpty
        ? " - ${translatedColors.join(', ')}"
        : "";

    return Card(
      child: ListTile(
        title: Text("$shapeText$colorsText"),
        subtitle: Text('${pattern.rows.length} sıra'),
        trailing: IconButton(
          icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border),
          onPressed: onLikeTap,
        ),
      ),
    );
  }
}
