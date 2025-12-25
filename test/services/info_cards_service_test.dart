import 'package:flutter_test/flutter_test.dart';
import 'package:jumpbook/services/info_cards_service.dart';
import 'package:jumpbook/models/jump_model.dart';

void main() {
  test('buildInfoCardsFromJumps returns placeholders on empty list', () {
    final cards = buildInfoCardsFromJumps([]);
    expect(cards.length, 4);
    for (final c in cards) {
      expect(c.mainText, '-');
    }
  });

  test('buildInfoCardsFromJumps computes correct metrics', () {
    final j1 = Jump(
      id: '1',
      aircraft: 'A',
      dropzone: 'DZ1',
      jumpType: 'Freefly',
      flightMode: 'F',
      canopySize: 100,
      date: DateTime(2025, 1, 1),
      exitAltitude: '12000',
      speedMax: '220',
      deployment: '4000',
      freefall: '30',
      observations: '',
      canopyTime: '90',
    );

    final j2 = Jump(
      id: '2',
      aircraft: 'B',
      dropzone: 'DZ2',
      jumpType: 'Freefly',
      flightMode: 'F',
      canopySize: 100,
      date: DateTime(2025, 2, 1),
      exitAltitude: '10000',
      speedMax: '200',
      deployment: '4000',
      freefall: '20',
      observations: '',
      canopyTime: '60',
    );

    final j3 = Jump(
      id: '3',
      aircraft: 'C',
      dropzone: 'DZ1',
      jumpType: 'RW',
      flightMode: 'F',
      canopySize: 100,
      date: DateTime(2025, 3, 1),
      exitAltitude: '13000',
      speedMax: '240',
      deployment: '4000',
      freefall: '40',
      observations: '',
      canopyTime: '120',
    );

    final cards = buildInfoCardsFromJumps([j1, j2, j3]);

    expect(cards.length, 4);
    expect(cards[0].mainText, '13,000 ft'); // Max exit (formatted)
    expect(cards[1].mainText, '240 km/h'); // Max speed
    expect(cards[2].mainText, 'Freefly'); // Most frequent discipline
    expect(cards[3].mainText, 'DZ1'); // Most frequent dropzone
  });
}
