import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/gen/assets.gen.dart';

class ExaminationCard extends StatelessWidget {
  final String title;
  final String kandungan;
  final double nilaiKandungan;
  final String persamaan;
  const ExaminationCard(
      {super.key,
      required this.title,
      required this.kandungan,
      required this.persamaan,
      required this.nilaiKandungan});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 1,
              child: Assets.images.icWarning.image(height: 80),
            ),
            const Gap(8),
            Flexible(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Gap(4),
                  Text(
                    "Kandungan $kandungan pada produk ini sebesar ${nilaiKandungan.toInt()}gr ($persamaan)!",
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontSize: 10,
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
