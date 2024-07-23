import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_button.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/core/widgets/app_theme.dart';
import 'package:nutrisee/gen/assets.gen.dart';

class ResultCaloriesScreen extends StatefulWidget {
  final Map<String, double> dataCalories;
  const ResultCaloriesScreen({super.key, required this.dataCalories});

  @override
  State<ResultCaloriesScreen> createState() => _ResultCaloriesScreenState();
}

class _ResultCaloriesScreenState extends State<ResultCaloriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBG,
      appBar: AppBar(
        title: const Text("Hasil Kalori Harian"),
        scrolledUnderElevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.go('/calories');
            },
            icon: const Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.marginHorizontal,
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Assets.images.icCalories.image(),
                  const Gap(16),
                  Container(
                    width: double.maxFinite,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.ancientSwatch.shade50,
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Hasil BMR",
                          style: context.textTheme.titleLarge?.copyWith(
                            fontSize: 18,
                            color: Colors.green.shade900,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(16),
                        Row(
                          children: [
                            Expanded(
                              child: itemCalories(
                                context,
                                widget.dataCalories['BMR']!.toInt(),
                                "BMR",
                              ),
                            ),
                            const Gap(24),
                            Expanded(
                              child: itemCalories(
                                context,
                                widget.dataCalories['TDEE']!.toInt(),
                                "Kalori/hari",
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Gap(16),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Rangkuman",
                      style: context.textTheme.titleMedium,
                    ),
                  ),
                  const Gap(10),
                  Text(
                    "Tubuh Anda akan membakar ${widget.dataCalories['BMR']!.toInt()} kalori (${(widget.dataCalories['BMR']! * 4.184).toInt()}kj) "
                    "setiap hari untuk menjalankan fungsi-fungsi yang "
                    "diperlukan. Perkiraan untuk mempertahankan berat "
                    "badan Anda saat ini (berdasarkan tingkat aktivitas "
                    "yang Anda pilih) adalah ${widget.dataCalories['TDEE']!.toInt()} kalori (${(widget.dataCalories['TDEE']! * 4.184).toInt()}kj). "
                    "Perhitungan ini menggunakan persamaan Mifflin - St Jeor.",
                    style: context.textTheme.bodyLarge,
                    textAlign: TextAlign.justify,
                  )
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: AppButton(
                      onPressed: () {
                        context.go('/menu');
                      },
                      caption: "Back to Home",
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container itemCalories(
    BuildContext context,
    int data,
    String title,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: const GradientBoxBorder(
          gradient: AppColors.greenGradient,
          width: 8,
        ),
      ),
      child: Column(
        children: [
          Text(
            data.toString(),
            style: context.textTheme.titleLarge,
          ),
          const Gap(8),
          Text(
            title,
            style: context.textTheme.bodyLarge?.copyWith(
              color: AppColors.ancient,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
