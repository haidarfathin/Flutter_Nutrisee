import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';

class QuestionerCard extends StatelessWidget {
  final String captions;
  final List<QuestionerOptions> options;
  final ValueNotifier<bool?> selectedOptionNotifier;
  final Function(bool)? onOptionsSelected;

  const QuestionerCard({
    super.key,
    required this.captions,
    required this.options,
    required this.selectedOptionNotifier,
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
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const Gap(10),
          ValueListenableBuilder<bool?>(
            valueListenable: selectedOptionNotifier,
            builder: (context, selectedOption, _) {
              return Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: options.isEmpty
                    ? [Container()]
                    : List.generate(
                        options.length,
                        (index) {
                          return GestureDetector(
                            onTap: () {
                              selectedOptionNotifier.value =
                                  options[index].isPositive;
                              if (onOptionsSelected != null) {
                                onOptionsSelected!(options[index].isPositive);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  width: 2,
                                  color: AppColors.primary,
                                ),
                                color:
                                    selectedOption == options[index].isPositive
                                        ? AppColors.primary
                                        : Colors.white,
                              ),
                              child: Text(
                                options[index].label,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: (selectedOption ==
                                              options[index].isPositive)
                                          ? Colors.white
                                          : AppColors.primary,
                                    ),
                              ),
                            ),
                          );
                        },
                      ),
              );
            },
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
