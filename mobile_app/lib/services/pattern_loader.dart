import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/pattern.dart';

const List<String> _patternFiles = [
  'circle_basic.json',
  'circle_repeat.json',
  'square_flat.json',
];

Future<List<CrochetPattern>> loadSamplePatterns() async {
  final patterns = <CrochetPattern>[];

  for (final file in _patternFiles) {
    final text = await rootBundle.loadString('assets/patterns/$file');
    final json = jsonDecode(text) as Map<String, dynamic>;
    patterns.add(CrochetPattern.fromJson(json));
  }

  return patterns;
}
