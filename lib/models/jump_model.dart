import 'package:cloud_firestore/cloud_firestore.dart';

class Jump {
  final String id;
  final String aircraft;
  final String dropzone;
  final String jumpType;
  final String flightMode;
  final int canopySize;
  final DateTime date;
  final String exitAltitude;
  final String speedMax;
  final String deployment;
  final String freefall;
  final String observations;
  final String canopyTime;

  Jump({
    required this.id,
    required this.aircraft,
    required this.dropzone,
    required this.jumpType,
    required this.flightMode,
    required this.canopySize,
    required this.date,
    required this.exitAltitude,
    required this.speedMax,
    required this.deployment,
    required this.freefall,
    required this.observations,
    required this.canopyTime,
  });

  factory Jump.fromFirestore(Map<String, dynamic> data, String id) {
    DateTime parsedDate;

    final rawDate = data['date'];

    if (rawDate is Timestamp) {
      parsedDate = rawDate.toDate();
    } else if (rawDate is String) {
      parsedDate = DateTime.tryParse(rawDate) ?? DateTime.now();
    } else {
      parsedDate = DateTime.now();
    }

    return Jump(
      id: id,
      aircraft: data['aircraft'] ?? 'N/A',
      dropzone: data['dropzone'] ?? 'N/A',
      jumpType: data['jumpType'] ?? 'N/A',
      flightMode: data['flightMode'] ?? 'N/A',
      canopySize: data['canopySize'] ?? 0,
      date: parsedDate,
      exitAltitude: data['exitAltitude'].toString(),
      speedMax: data['speedMax'].toString(),
      deployment: data['deployment'].toString(),
      freefall: data['freefall'].toString(),
      observations: data['observations'] ?? '',
      canopyTime: data['canopyTime'] ?? '',
    );
  }
}
