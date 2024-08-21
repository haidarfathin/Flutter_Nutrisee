import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gap/gap.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nutrisee/core/data/model/article/listArticles.dart';
import 'package:nutrisee/core/data/prompt.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_theme.dart';
import 'package:nutrisee/gen/assets.gen.dart';
import 'package:nutrisee/ui/history/cubit/history_cubit.dart';
import 'package:nutrisee/ui/home/widget/item_menu.dart';
import 'package:nutrisee/ui/home/widget/item_scan.dart';

import '../../../core/widgets/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? helloPrompt;

  ListArticles listArticles = ListArticles();

  @override
  void initState() {
    super.initState();
    generatePrompt();
  }

  final Gemini gemini = Gemini.instance;
  Future<void> generatePrompt() async {
    final result = await gemini.text(
      Prompt.sayHelloToUser.replaceFirst('[user]', 'Jaka'),
    );

    final hello = result?.content?.parts?.last.text ?? 'No analysis available';
    log(hello);
    setState(() {
      helloPrompt = hello;
    });
  }

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
        "route": "/count-bmi",
      },
      {
        "icon": Assets.images.icDiabetesTest.image(),
        "title": "Risiko Diabetes",
        "route": "/diabetes-risk",
      },
      // {
      //   "icon": Assets.images.icRemindMed.image(),
      //   "title": "Pengingat Obat",
      //   "route": "/meds",
      // }
    ];

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.whiteBG,
        centerTitle: false,
        title: Text(
          "Glukosaw",
          style: context.textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.w800, color: AppColors.primary),
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
                            "Mari jaga asupan\ngula kita!",
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
                      "Saran Minsaw AI",
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
                          helloPrompt == null
                              ? const Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              : Expanded(
                                  flex: 4,
                                  child: Text(
                                    helloPrompt ?? "",
                                    style:
                                        context.textTheme.bodySmall?.copyWith(
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
                  ],
                ),
              ),
            ),
            BlocProvider(
              create: (context) => HistoryCubit()..getUserHistory(),
              child: BlocBuilder<HistoryCubit, HistoryState>(
                builder: (context, state) {
                  if (state is GetHistoryLoading) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is GetHistorySuccess) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: ScanItem(
                              data: state.scannedProduct[index],
                            ),
                          );
                        },
                        childCount: state.scannedProduct.length > 3
                            ? 3
                            : state.scannedProduct.length,
                      ),
                    );
                  } else if (state is GetHistoryError) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text("Error: ${state.message}"),
                      ),
                    );
                  } else {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: Text('No data'),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
