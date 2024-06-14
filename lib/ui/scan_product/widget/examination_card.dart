import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/gen/assets.gen.dart';

class ExaminationCard extends StatelessWidget {
  const ExaminationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Assets.images.icWarning.image(height: 60),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Kandungan Gula Tinggi",
              style: context.textTheme.bodyLarge?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(4),
            Expanded(
              child: Text(
                "Kandungan gula pada produk ini sebesar 19g (1 sdm)!",
                style: context.textTheme.bodyLarge?.copyWith(fontSize: 10),
              ),
            ),
          ],
        )
      ],
    );
  }
}
