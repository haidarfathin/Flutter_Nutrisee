import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';

class NutritionContainer extends StatelessWidget {
  final double kandungan;
  final Color background;
  final String title;

  const NutritionContainer({
    super.key,
    required this.kandungan,
    required this.background,
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
            style: context.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: batasHarian == kandungan
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.grayBG,
                  border: Border.all(
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: proportionalHeight,
                  decoration: BoxDecoration(
                    color: background,
                    borderRadius: batasHarian == kandungan
                        ? BorderRadius.circular(20)
                        : const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
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
                      color: AppColors.whiteBG,
                      fontWeight: FontWeight.bold,
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
}
