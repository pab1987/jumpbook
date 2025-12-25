import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jumpbook/models/info_card_data.dart';
import 'package:jumpbook/providers/jump_providers.dart';
import 'package:jumpbook/services/info_cards_service.dart';

final infoCardsProvider = Provider<List<InfoCardData>>((ref) {
  final jumpsAsync = ref.watch(jumpsStreamProvider);

  return jumpsAsync.when(
    data: (jumps) => buildInfoCardsFromJumps(jumps),
    loading: () => buildInfoCardsFromJumps([]),
    error: (_, __) => buildInfoCardsFromJumps([]),
  );
});