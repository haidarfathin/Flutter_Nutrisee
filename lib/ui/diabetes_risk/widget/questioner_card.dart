import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';

class QuestionerCard extends StatelessWidget {
  const QuestionerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 15,
            offset: const Offset(1, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            "Apakah kakek, bibi, paman, atau sepupu pertama pernah didiagnosis Diabetes?",
            style: context.textTheme.bodyLarge,
          ),
          Gap(10),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    width: 2,
                    color: AppColors.greenSwatch.shade100,
                  ),
                ),
                child: Text(
                  "Ya",
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.greenSwatch.shade100,
                  ),
                ),
              ),
              Gap(20),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    width: 2,
                    color: AppColors.orangeSwatch.shade400,
                  ),
                ),
                child: Text(
                  "Tidak",
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.orangeSwatch.shade400,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
