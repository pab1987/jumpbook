import 'package:flutter_test/flutter_test.dart';
import 'package:jumpbook/models/home_stats.dart';
import 'package:jumpbook/models/jump_model.dart';

void main() {
  test('computeStats returns zeros for empty list', () {
    final stats = computeStats([]);
    expect(stats.currentJumps, 0);
    expect(stats.canopyHours, 0.0);
    expect(stats.freeFallHours, 0.0);
    expect(stats.jpm, 0.0);
  });

  test('computeStats computes correct aggregates', () {
    final jump1 = Jump(
      id: '1',
      aircraft: 'A',
      dropzone: 'D',
      jumpType: 'T',
      flightMode: 'F',
      canopySize: 100,
      date: DateTime(2025, 1, 15),
      exitAltitude: '12000',
      speedMax: '200',
      deployment: '4000',
      freefall: '30',
      observations: '',
      canopyTime: '90',
    );

    final jump2 = Jump(
      id: '2',
      aircraft: 'A',
      dropzone: 'D',
      jumpType: 'T',
      flightMode: 'F',
      canopySize: 90,
      date: DateTime(2025, 2, 10),
      exitAltitude: '12000',
      speedMax: '210',
      deployment: '3000',
      freefall: '20',
      observations: '',
      canopyTime: '120',
    );

    final stats = computeStats([jump1, jump2]);

    // canopy seconds = 90 + 120 = 210 -> hours = 210 / 3600 = 0.0583 -> rounded 0.1
    expect(stats.canopyHours, 0.1);

    // freefall seconds = 30 + 20 = 50 -> hours = 50/3600 = 0.0138 -> rounded 0.0
    expect(stats.freeFallHours, 0.0);

    expect(stats.currentJumps, 2);
    expect(stats.lastJumpDate.isNotEmpty, true);
    expect(stats.jpm, greaterThan(0));
  });
}
