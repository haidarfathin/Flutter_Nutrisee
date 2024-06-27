import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_theme.dart';
import 'package:nutrisee/gen/assets.gen.dart';
import 'package:nutrisee/ui/home/widget/item_menu.dart';
import 'package:nutrisee/ui/home/widget/item_scan.dart';

import '../../../core/widgets/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        "icon": Assets.images.icNutrition.image(),
        "title": "Kalori Harian",
        "route": "/calories",
      },
      {
        "icon": Assets.images.icCount.image(),
        "title": "Hitung BMI",
        "route": "/bmi",
      },
      {
        "icon": Assets.images.icDiabetesTest.image(),
        "title": "Risiko Diabetes",
        "route": "/diabetes-risk",
      },
      {
        "icon": Assets.images.icRemindMed.image(),
        "title": "Pengingat Obat",
        "route": "/meds",
      }
    ];

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.whiteBG,
        centerTitle: false,
        title: Text(
          "Hi, Haidar",
          style: context.textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.w800),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: AppTheme.marginHorizontal),
            child: Icon(
              Ionicons.notifications,
              color: AppColors.secondary,
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.whiteBG,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.marginHorizontal,
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  gradient: AppColors.greenGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Yuk, Mulai Hidup Sehat",
                            style: context.textTheme.headlineLarge?.copyWith(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          const Gap(4),
                          Text(
                            "Mari jaga asupan\nnutrisi kita!",
                            style: context.textTheme.bodyLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Assets.images.icWomenEat.image(),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 120,
                child: Row(
                  children: List.generate(menuItems.length, (index) {
                    final item = menuItems[index];
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: MenuItem(
                          icon: item['icon'],
                          title: item['title'],
                          route: item['route'],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Saran Nutrisi AI",
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Gap(8),
                    Container(
                      height: 100,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.orangeSwatch.shade50,
                        border: const GradientBoxBorder(
                          gradient: AppColors.orangeGradient,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Assets.images.icBulb.image(),
                          ),
                          const Gap(8),
                          Expanded(
                            flex: 4,
                            child: Text(
                              "Anda sudah mengonsumsi 40g gula hari ini, "
                              "mendekati batas maksimal 50g (4 sdm). "
                              "Cobalah untuk menghindari makanan dan "
                              "minuman bergula!",
                              style: context.textTheme.bodySmall?.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Riwayat Pindai",
                          style: context.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Lihat Semua",
                          style: context.textTheme.bodySmall,
                        )
                      ],
                    ),
                    const Gap(12),
                    const ScanItem(),
                    const Gap(8),
                    const ScanItem(),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Artikel Terbaru",
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Gap(8),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 250,
                            margin: const EdgeInsets.only(right: 14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: 75,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                    color: Colors.green,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 16,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Sayuran Yang Cocok Untuk Pengidap Diabetes",
                                        style: context.textTheme.bodyLarge
                                            ?.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      const Gap(8),
                                      Text(
                                        "Kamu harus cermat saat memilih "
                                        "sayur dan buah untuk penderita diabetes. "
                                        "Soalnya, tidak semua jenis buah aman buat "
                                        "penderita diabetes,",
                                        style: context.textTheme.bodySmall
                                            ?.copyWith(fontSize: 10),
                                        textAlign: TextAlign.justify,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
