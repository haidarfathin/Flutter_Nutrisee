import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';

class NutritionContainer extends StatelessWidget {
  final double kandungan;
  final Color background;
  final String title;
  final String subtitle;
  const NutritionContainer({
    super.key,
    required this.kandungan,
    required this.background,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    double batasHarian = 0;
    if (title == "Gula") {
      batasHarian = 50;
    } else if (title == "Lemak Jenuh") {
      batasHarian = 70;
    } else if (title == "Garam") {
      batasHarian = 2000;
    }
    double proportionalHeight = (kandungan / batasHarian) * 150;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          width: 100,
          child: Text(
            title,
            style: context.textTheme.bodySmall,
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
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: proportionalHeight,
                  decoration: BoxDecoration(
                    color: background,
                    borderRadius: BorderRadius.only(
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
                    subtitle,
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
