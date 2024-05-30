import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';

class DiabetesTypeRadio extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final Function onTap;

  const DiabetesTypeRadio({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.ancientSwatch.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: isSelected
              ? const GradientBoxBorder(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF90C788),
                      Color(0xFF049913),
                    ],
                    stops: [0.56, 1.0],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  width: 4,
                )
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.textTheme.titleLarge?.copyWith(
                color: isSelected ? AppColors.primary : AppColors.textGray,
              ),
            ),
            const Gap(8),
            Text(
              subtitle,
              style: context.textTheme.bodyLarge?.copyWith(
                color: isSelected ? AppColors.primary : AppColors.textGray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
