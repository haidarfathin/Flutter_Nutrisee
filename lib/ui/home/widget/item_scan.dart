import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nutrisee/core/data/model/firestore/scanned_products.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/gen/assets.gen.dart';

class ScanItem extends StatelessWidget {
  final ScannedProduct data;
  const ScanItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Image.network(
              data.image,
              fit: BoxFit.cover,
              width: 50,
              height: 50,
            ),
          ),
          Gap(14),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name,
                  style: context.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.w900),
                ),
                Gap(4),
                data.isSugarHighest
                    ? Text(
                        "Gula: ${data.totalSugar}gr",
                        style: context.textTheme.bodySmall
                            ?.copyWith(fontWeight: FontWeight.w600),
                      )
                    : Text(
                        "Garam: ${data.salt}mg",
                        style: context.textTheme.bodySmall
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
              ],
            ),
          ),
          showNutriScore(data.score),
        ],
      ),
    );
  }
}

Image showNutriScore(String score) {
  if (score.toLowerCase() == "a") {
    return Assets.images.icScoreA.image(height: 55);
  } else if (score.toLowerCase() == "b") {
    return Assets.images.icScoreB.image(height: 55);
  } else if (score.toLowerCase() == "c") {
    return Assets.images.icScoreC.image(height: 55);
  } else {
    return Assets.images.icScoreD.image(height: 55);
  }
}
