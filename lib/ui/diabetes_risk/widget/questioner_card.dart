import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';

class QuestionerCard extends StatelessWidget {
  final String captions;
  final List<QuestionerOptions> options;
  final Function()? onOptionsSelected;

  const QuestionerCard({
    super.key,
    required this.captions,
    required this.options,
    this.onOptionsSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            captions,
            style: context.textTheme.bodyLarge,
          ),
          const Gap(10),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: options.isEmpty
                ? [Container()]
                : List.generate(
                    options.length,
                    (index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            width: 2,
                            color: options[index].isPositive
                                ? AppColors.greenSwatch.shade100
                                : AppColors.orangeSwatch.shade400,
                          ),
                        ),
                        child: Text(
                          options[index].label,
                          style: context.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: options[index].isPositive
                                ? AppColors.greenSwatch.shade100
                                : AppColors.orangeSwatch.shade400,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class QuestionerOptions {
  final String label;
  final bool isPositive;

  QuestionerOptions({
    required this.label,
    required this.isPositive,
  });
}
