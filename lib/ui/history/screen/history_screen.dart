import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/utils/translation.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/core/widgets/app_theme.dart';
import 'package:nutrisee/ui/home/widget/item_scan.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBG,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.marginHorizontal,
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                "Riwayat Pindai",
                style: context.textTheme.titleMedium,
              ),
              collapsedHeight: 230,
              scrolledUnderElevation: 0,
              pinned: true,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(0.0),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Row(
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: GradientBoxBorder(
                            gradient: AppColors.greenGradient,
                            width: 20,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "15",
                              style: context.textTheme.displayLarge?.copyWith(
                                color: AppColors.primary,
                                fontSize: 36,
                              ),
                            ),
                            Text(
                              "Scan",
                              style: context.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.ancient,
                              ),
                            )
                          ],
                        ),
                      ),
                      Gap(12),
                      Column(
                        children: [
                          Text(
                            "Produk dipindai minggu ini",
                            style: context.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 11),
                          ),
                          Gap(10),
                          Row(
                            children: [
                              Container(
                                width: 80,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 5,
                                      blurRadius: 15,
                                      offset: const Offset(1, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "5",
                                      style:
                                          context.textTheme.bodyLarge?.copyWith(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.secondary,
                                      ),
                                    ),
                                    Text(
                                      "Gula Tinggi",
                                      style:
                                          context.textTheme.bodyLarge?.copyWith(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                    )
                                  ],
                                ),
                              ),
                              Gap(14),
                              Container(
                                width: 80,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 5,
                                      blurRadius: 15,
                                      offset: const Offset(1, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "10",
                                      style:
                                          context.textTheme.bodyLarge?.copyWith(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.secondary,
                                      ),
                                    ),
                                    Text(
                                      "Garam Tinggi",
                                      style:
                                          context.textTheme.bodyLarge?.copyWith(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: Text(
                  "Hari Ini",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: ScanItem(),
                  );
                },
                childCount: 7, // Number of items in the list
              ),
            ),
          ],
        ),
      ),
    );
  }
}
