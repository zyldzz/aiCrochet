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

  // Renklerin düz yazı (Türkçe) karşılıkları için yeni harita
  static const Map<String, String> _colorNamesTr = {
    'red': 'Kırmızı',
    'yellow': 'Sarı',
    'blue': 'Mavi',
    'green': 'Yeşil',
  };

  @override
  Widget build(BuildContext context) {
    // Şeklin Türkçe adını al, yoksa ham halini kullan
    final shapeText = _shapeNames[pattern.shape] ?? pattern.shape;

    // Listedeki İngilizce renkleri Türkçe isimlerine dönüştür
    final translatedColors = pattern.colors
        .map((color) => _colorNamesTr[color] ?? color)
        .toList();

    // Renkler varsa aralarına virgül koyarak birleştir, yoksa boş bırak
    final colorsText = translatedColors.isNotEmpty
        ? " - ${translatedColors.join(', ')}"
        : "";

    return Card(
      child: ListTile(
        // Sol taraftaki CircleAvatar (nokta) tamamen kaldırıldı
        title: Text(
          "$shapeText$colorsText",
        ), // Örn: "Daire - Kırmızı, Mavi" veya sadece "Kare"
        subtitle: Text('${pattern.rows.length} sıra'),
        trailing: IconButton(
          icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border),
          onPressed: onLikeTap,
        ),
      ),
    );
  }
}
