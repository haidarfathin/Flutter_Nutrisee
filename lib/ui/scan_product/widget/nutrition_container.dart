import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';

class NutritionContainer extends StatelessWidget {
  final double kandungan;
  final String title;

  const NutritionContainer({
    super.key,
    required this.kandungan,
    required this.title,
  });

  double getBatasHarian(String title) {
    switch (title.toLowerCase()) {
      case 'gula':
        return 50.0;
      case 'garam':
        return 2000.0;
      case 'lemak':
        return 70.0;
      default:
        return 100.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double batasHarian = getBatasHarian(title);
    final double proportionalHeight = (kandungan / batasHarian) * 150;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          width: 100,
          child: Text(
            title,
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 11,
              color: kandungan > (0.5 * batasHarian)
                  ? Colors.redAccent.shade700
                  : AppColors.textGray,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Gap(12),
        Container(
          width: MediaQuery.of(context).size.width / 3 - 30,
          height: 150,
          child: Stack(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ]),
                child: Container(
                  height: proportionalHeight,
                  decoration: BoxDecoration(
                    color: examineBackground(kandungan, title),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    title.toLowerCase() == "garam"
                        ? "${kandungan.toInt()}mg"
                        : "${kandungan.toInt()}gr",
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: proportionalHeight <= 20
                          ? AppColors.textBlack
                          : Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Color examineBackground(double kandungan, String title) {
    if (title == "Gula") {
      if (kandungan >= 10 && kandungan < 35) {
        return Colors.orange.shade400;
      } else if (kandungan >= 35) {
        return Colors.red.shade400;
      } else {
        return Colors.green.shade400;
      }
    } else if (title == "Garam") {
      if (kandungan >= 200 && kandungan < 1500) {
        return Colors.orange.shade400;
      } else if (kandungan >= 1500) {
        return Colors.red.shade400;
      } else {
        return Colors.green.shade400;
      }
    } else if (title == "Lemak Jenuh") {
      if (kandungan >= 10 && kandungan < 50) {
        return Colors.orange.shade400;
      } else if (kandungan >= 50) {
        return Colors.red.shade400;
      } else {
        return Colors.green.shade400;
      }
    } else {
      return Colors.black;
    }
  }
}
