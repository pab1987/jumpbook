import 'package:jumpbook/models/jump_model.dart';

class HomeStats {
  final double canopyHours;
  final double freeFallHours;
  final int currentJumps;
  final int targetJumps;
  final String lastJumpDate;
  final double jpm;

  HomeStats({
    required this.canopyHours,
    required this.freeFallHours,
    required this.currentJumps,
    required this.targetJumps,
    required this.lastJumpDate,
    required this.jpm,
  });

  factory HomeStats.fromMap(Map<String, dynamic> map) {
    return HomeStats(
      canopyHours: map['canopyHours'] ?? 0.0,
      freeFallHours: map['freeFallHours'] ?? 0.0,
      currentJumps: map['currentJumps'] ?? 0,
      targetJumps: map['targetJumps'] ?? 100,
      lastJumpDate: map['lastJumpDate'] ?? '',
      jpm: map['jpm'] ?? 0.0,
    );
  }
}

/// Compute HomeStats from a list of [Jump]s.
HomeStats computeStats(List<Jump> jumps) {
  final nonNull = jumps.whereType<Jump>().toList();
  if (nonNull.isEmpty) {
    return HomeStats(
      canopyHours: 0.0,
      freeFallHours: 0.0,
      currentJumps: 0,
      targetJumps: 100,
      lastJumpDate: '',
      jpm: 0.0,
    );
  }

  // Sumas de tiempos (se espera que los campos sean strings con segundos)
  double totalCanopySeconds = 0;
  double totalFreefallSeconds = 0;

  for (final j in nonNull) {
    final canopy = double.tryParse(j.canopyTime) ?? 0.0;
    final freefall = double.tryParse(j.freefall) ?? 0.0;
    totalCanopySeconds += canopy;
    totalFreefallSeconds += freefall;
  }

  final canopyHours = double.parse((totalCanopySeconds / 3600).toStringAsFixed(1));
  final freeFallHours = double.parse((totalFreefallSeconds / 3600).toStringAsFixed(1));

  // Último salto (calculamos explicitamente por si el stream no viene ordenado)
  final latest = nonNull.reduce((a, b) => a.date.isAfter(b.date) ? a : b);
  final earliest = nonNull.reduce((a, b) => a.date.isBefore(b.date) ? a : b);

  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  final lastJumpDate = formatDate(latest.date);

  // Jumps per month (jumps / months since first jump)
  final now = DateTime.now();
  final monthsSpan = ((now.year - earliest.date.year) * 12 + (now.month - earliest.date.month)).abs() + 1;
  final jpm = double.parse((nonNull.length / monthsSpan).toStringAsFixed(1));

  return HomeStats(
    canopyHours: canopyHours,
    freeFallHours: freeFallHours,
    currentJumps: nonNull.length,
    targetJumps: 100,
    lastJumpDate: lastJumpDate,
    jpm: jpm,
  );
}
