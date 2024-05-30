import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: const GradientBoxBorder(
          gradient: AppColors.greenGradient,
        ),
        color: Colors.white,
      ),
      child: Center(
          child: Row(
        children: [
          Text(
            "25",
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          Gap(4),
          Text(
            "tahun",
            style: context.textTheme.bodyLarge?.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AppColors.ancientSwatch.shade300,
            ),
          ),
          Gap(6),
          InkWell(
            onTap: () {},
            child: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.ancientSwatch.shade100),
              child: const Icon(
                Icons.edit_square,
                size: 12,
                color: AppColors.primary,
              ),
            ),
          )
        ],
      )),
    );
  }
}
