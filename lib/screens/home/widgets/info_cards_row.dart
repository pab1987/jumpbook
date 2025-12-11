import 'package:flutter/material.dart';
import 'package:jumpbook/widgets/misc/info_card.dart';
import 'package:jumpbook/widgets/layout/custom_container.dart';

class InfoCardsRow extends StatelessWidget {
  const InfoCardsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      {
        "icon": "assets/icons/exit_altitude.png",
        "main": "12.000 ft",
        "sub1": "Avg exit",
        "sub2": "Altitude",
      },
      {
        "icon": "assets/icons/freefall.png",
        "main": "393 km/h",
        "sub1": "Top Freefall",
        "sub2": "Speed",
      },
      {
        "icon": "assets/icons/freefly.png",
        "main": "Freefly",
        "sub1": "Main",
        "sub2": "Discipline",
      },
      {
        "icon": "assets/icons/dropzone.png",
        "main": "Xielo",
        "sub1": "Mostly",
        "sub2": "DZ",
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: data.map((item) {
        return SizedBox(
          width: 95,
          height: 135,
          child: JumpbookCard(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: InfoCard(
                iconAsset: item["icon"]!,
                mainText: item["main"]!,
                subTexts: [item["sub1"]!, item["sub2"]!],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
