import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/gen/assets.gen.dart';

class ScanItem extends StatelessWidget {
  const ScanItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Assets.images.icDiabetesTest.image(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "19.30 - 15 Mei",
                  style: context.textTheme.labelSmall,
                ),
                Text(
                  "Susu Indomilk",
                  style: context.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Gap(4),
                Text(
                  "220kkal",
                  style: context.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Image.asset(
            'assets/images/ic_nutriscore.png',
          ),
        ],
      ),
    );
  }
}
