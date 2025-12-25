import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jumpbook/widgets/misc/info_card.dart';
import 'package:jumpbook/widgets/layout/custom_container.dart';
import 'package:jumpbook/providers/info_cards_provider.dart';

class InfoCardsRow extends ConsumerWidget {
  const InfoCardsRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cards = ref.watch(infoCardsProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: cards.map((item) {
        return SizedBox(
          width: 95,
          height: 135,
          child: JumpbookCard(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: InfoCard(
                iconAsset: item.iconAsset,
                mainText: item.mainText,
                subTexts: [item.sub1, item.sub2],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
