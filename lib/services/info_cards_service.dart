import 'package:jumpbook/models/jump_model.dart';
import 'package:jumpbook/models/info_card_data.dart';
import 'package:intl/intl.dart';

/// Construye la lista de `InfoCardData` a partir de la lista real de saltos.
List<InfoCardData> buildInfoCardsFromJumps(List<Jump> jumps) {
  String formatUnknown() => '-';

  if (jumps.isEmpty) {
    return [
      InfoCardData(
        iconAsset: 'assets/icons/exit_altitude.png',
        mainText: formatUnknown(),
        sub1: 'Max',
        sub2: 'Exit',
      ),
      InfoCardData(
        iconAsset: 'assets/icons/freefall.png',
        mainText: formatUnknown(),
        sub1: 'Top',
        sub2: 'Freefall',
      ),
      InfoCardData(
        iconAsset: 'assets/icons/freefly.png',
        mainText: formatUnknown(),
        sub1: 'Main',
        sub2: 'Discipline',
      ),
      InfoCardData(
        iconAsset: 'assets/icons/dropzone.png',
        mainText: formatUnknown(),
        sub1: 'Mostly',
        sub2: 'DZ',
      ),
    ];
  }

  double? parseNumber(String value) {
    final match = RegExp(r"(\d+(?:[.,]\d+)?)").firstMatch(value);
    if (match == null) return null;
    // Replace comma with dot for decimals
    final raw = match.group(0)!.replaceAll(',', '.');
    return double.tryParse(raw);
  }

  double? maxExit;
  double? maxSpeed;
  final Map<String, int> disciplineCount = {};
  final Map<String, int> dropzoneCount = {};

  for (final j in jumps) {
    final exit = parseNumber(j.exitAltitude);
    if (exit != null) maxExit = (maxExit == null) ? exit : (exit > maxExit ? exit : maxExit);

    final speed = parseNumber(j.speedMax);
    if (speed != null) maxSpeed = (maxSpeed == null) ? speed : (speed > maxSpeed ? speed : maxSpeed);

    final disc = (j.jumpType).trim();
    if (disc.isNotEmpty) {
      disciplineCount[disc] = (disciplineCount[disc] ?? 0) + 1;
    }

    final dz = (j.dropzone).trim();
    if (dz.isNotEmpty) {
      dropzoneCount[dz] = (dropzoneCount[dz] ?? 0) + 1;
    }
  }

  String chooseMostFrequent(Map<String, int> counts) {
    if (counts.isEmpty) return formatUnknown();
    final entries = counts.entries.toList();
    entries.sort((a, b) => b.value.compareTo(a.value));
    return entries.first.key;
  }

  final formatter = NumberFormat.decimalPattern('en_US');
  String exitText = maxExit != null ? '${formatter.format(maxExit.toInt())} ft' : formatUnknown();
  String speedText = maxSpeed != null ? '${formatter.format(maxSpeed.toInt())} km/h' : formatUnknown();
  String disciplineText = chooseMostFrequent(disciplineCount);
  String dropzoneText = chooseMostFrequent(dropzoneCount);

  return [
    InfoCardData(
      iconAsset: 'assets/icons/exit_altitude.png',
      mainText: exitText,
      sub1: 'Max',
      sub2: 'Exit',
    ),
    InfoCardData(
      iconAsset: 'assets/icons/freefall.png',
      mainText: speedText,
      sub1: 'Top',
      sub2: 'Freefall',
    ),
    InfoCardData(
      iconAsset: 'assets/icons/freefly.png',
      mainText: disciplineText,
      sub1: 'Main',
      sub2: 'Discipline',
    ),
    InfoCardData(
      iconAsset: 'assets/icons/dropzone.png',
      mainText: dropzoneText,
      sub1: 'Mostly',
      sub2: 'DZ',
    ),
  ];
}
