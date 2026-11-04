class StitchGroup {
  const StitchGroup({required this.type, required this.count});

  final String type;
  final int count;

  factory StitchGroup.fromJson(Map<String, dynamic> json) {
    return StitchGroup(
      type: json['type'] as String,
      count: json['count'] as int,
    );
  }
}

class PatternRow {
  const PatternRow({
    required this.no,
    required this.stitches,
    this.repeat = 1,
    this.total,
  });

  final int no;
  final List<StitchGroup> stitches;
  final int repeat;
  final int? total;

  factory PatternRow.fromJson(Map<String, dynamic> json) {
    return PatternRow(
      no: json['no'] as int,
      stitches: (json['stitches'] as List)
          .map((s) => StitchGroup.fromJson(s as Map<String, dynamic>))
          .toList(),
      repeat: json['repeat'] as int? ?? 1,
      total: json['total'] as int?,
    );
  }
}

class CrochetPattern {
  const CrochetPattern({
    required this.shape,
    required this.colors,
    required this.rows,
    this.start,
  });

  final String shape;
  final List<String> colors;
  final List<PatternRow> rows;
  final String? start;

  factory CrochetPattern.fromJson(Map<String, dynamic> json) {
    return CrochetPattern(
      shape: json['shape'] as String,
      colors: (json['colors'] as List).map((c) => c as String).toList(),
      rows: (json['rows'] as List)
          .map((r) => PatternRow.fromJson(r as Map<String, dynamic>))
          .toList(),
      start: json['start'] as String?,
    );
  }
}
