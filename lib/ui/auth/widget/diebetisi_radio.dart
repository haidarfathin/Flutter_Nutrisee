import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';

class DiabetisiRadio extends StatelessWidget {
  final String title;
  final Widget image;
  final bool isSelected;
  final Function onTap;

  const DiabetisiRadio({
    Key? key,
    required this.title,
    required this.image,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: 130,
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
          children: [
            image,
            const Gap(24),
            Text(
              title,
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: isSelected ? AppColors.primary : AppColors.textGray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
