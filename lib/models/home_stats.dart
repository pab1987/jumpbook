class HomeStats {
  final double canopyHours;
  final double freeflyHours;
  final int currentJumps;
  final int targetJumps;
  final String lastJumpDate;
  final double jpm;

  HomeStats({
    required this.canopyHours,
    required this.freeflyHours,
    required this.currentJumps,
    required this.targetJumps,
    required this.lastJumpDate,
    required this.jpm,
  });

  factory HomeStats.fromMap(Map<String, dynamic> map) {
    return HomeStats(
      canopyHours: map['canopyHours'] ?? 0.0,
      freeflyHours: map['freeflyHours'] ?? 0.0,
      currentJumps: map['currentJumps'] ?? 0,
      targetJumps: map['targetJumps'] ?? 100,
      lastJumpDate: map['lastJumpDate'] ?? '',
      jpm: map['jpm'] ?? 0.0,
    );
  }
}
