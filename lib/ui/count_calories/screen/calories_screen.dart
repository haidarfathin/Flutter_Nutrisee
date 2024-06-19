import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_button.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/core/widgets/app_theme.dart';
import 'package:nutrisee/gen/assets.gen.dart';

class CaloriesScreen extends StatefulWidget {
  const CaloriesScreen({super.key});

  @override
  State<CaloriesScreen> createState() => _CaloriesScreenState();
}

class _CaloriesScreenState extends State<CaloriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBG,
      appBar: AppBar(
        title: const Text("Hitung Kalori Harian"),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.marginHorizontal,
          vertical: AppTheme.marginVertical,
        ),
        child: Column(
          children: [
            Assets.images.icHealthyFood.image(height: 240),
            const Gap(20),
            Text(
              "Hitung Kebutuhan Kalori \nHarian Anda",
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Kalkulator kebutuhan kalori merupakan alat untuk "
                "menghitung perkiraan jumlah kalori yang anda "
                "butuhkan dalam sehari berdasarkan usia, berat badan, "
                "tinggi badan, dan tingkat aktivitas fisik anda."
                "Hasil perhitungan ini dibutuhkan untuk menakar kebutuhan "
                "asupan gula, garam, dan lemak tubuh anda.",
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.textGray,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: AppColors.lightGreenGradient,
              ),
              child: Row(
                children: [
                  Assets.images.icFood.image(height: 60),
                  const Gap(12),
                  Expanded(
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        text: "Nutrisee ",
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                        children: [
                          TextSpan(
                            text: "menggunakan kalori harian yang anda "
                                "simpan untuk mengatur tingkat sensitivitas "
                                "penilaian nutrisi produk yang anda pindai.",
                            style: context.textTheme.bodyLarge?.copyWith(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Gap(20),
            AppButton(
              onPressed: () {
                context.push('/count-calories');
              },
              caption: "Mulai Tes",
            ),
          ],
        ),
      ),
    );
  }
}
