import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/core/widgets/app_theme.dart';
import 'package:nutrisee/ui/history/cubit/history_cubit.dart';
import 'package:nutrisee/ui/home/widget/item_scan.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final cubit = HistoryCubit();
  String? selectedValue = "daily";
  final List<String> _dropdownItems = ['daily', 'weekly'];

  @override
  void initState() {
    super.initState();
    cubit.getUserHistory();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        context.go('/home');
      },
      child: BlocProvider(
        create: (context) => cubit..getUserHistory(),
        child: Scaffold(
          backgroundColor: AppColors.whiteBG,
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.marginHorizontal,
            ),
            child: RefreshIndicator(
              onRefresh: () async => cubit.getUserHistory(),
              child: CustomScrollView(
                slivers: [
                  // ... (Previous SliverAppBar code remains the same)
                  SliverAppBar(
                    title: Text(
                      "Riwayat Pindai",
                      style: context.textTheme.titleMedium,
                    ),
                    collapsedHeight: 300,
                    scrolledUnderElevation: 0,
                    pinned: true,
                    leading: IconButton(
                      onPressed: () {
                        context.go('/home');
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(0.0),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: BlocBuilder<HistoryCubit, HistoryState>(
                          builder: (context, state) {
                            if (state is GetHistorySuccess) {
                              return Column(
                                children: [
                                  if (state.todaySugar > 50 ||
                                      state.todaySalt > 2000)
                                    Container(
                                        width: double.maxFinite,
                                        height: 50,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 6),
                                        margin:
                                            const EdgeInsets.only(bottom: 20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.red.shade400,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Anda telah melewati batas harian konsumsi",
                                            style: context.textTheme.bodyLarge
                                                ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ))
                                  else
                                    Container(
                                        width: double.maxFinite,
                                        height: 50,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 6),
                                        margin:
                                            const EdgeInsets.only(bottom: 20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.green.shade400,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Batas konsumsi harian: Gula (50gr) Garam (2gr)",
                                            style: context.textTheme.bodyLarge
                                                ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                        )),
                                  Row(
                                    children: [
                                      Container(
                                        height: 140,
                                        width: 140,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          border: GradientBoxBorder(
                                            gradient: AppColors.greenGradient,
                                            width: 15,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${state.totalScanned}",
                                              style: context
                                                  .textTheme.displayLarge
                                                  ?.copyWith(
                                                color: AppColors.primary,
                                                fontSize: 36,
                                              ),
                                            ),
                                            Text(
                                              "Produk",
                                              style: context.textTheme.bodyLarge
                                                  ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.ancient,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const Gap(12),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: DropdownButton<String>(
                                              value: selectedValue,
                                              hint: Text(
                                                "Select an option",
                                                style:
                                                    context.textTheme.bodySmall,
                                              ),
                                              items: _dropdownItems
                                                  .map((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style: context
                                                        .textTheme.bodySmall,
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                if (newValue!.toLowerCase() ==
                                                    "daily") {
                                                  setState(() {
                                                    selectedValue = "daily";
                                                  });
                                                } else {
                                                  setState(() {
                                                    selectedValue = "weekly";
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                          const Gap(10),
                                          Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.1),
                                                      spreadRadius: 5,
                                                      blurRadius: 15,
                                                      offset:
                                                          const Offset(1, 3),
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      formatAngka(
                                                          selectedValue ==
                                                                  "daily"
                                                              ? state.todaySugar
                                                              : state
                                                                  .weeklySugar),
                                                      style:
                                                          GoogleFonts.notoSans(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color:
                                                            AppColors.secondary,
                                                      ),
                                                    ),
                                                    const Gap(8),
                                                    Text(
                                                      "Total Gula",
                                                      style: context
                                                          .textTheme.bodyLarge
                                                          ?.copyWith(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 2,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const Gap(12),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.1),
                                                      spreadRadius: 5,
                                                      blurRadius: 15,
                                                      offset:
                                                          const Offset(1, 3),
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      formatAngka(selectedValue ==
                                                              "daily"
                                                          ? (state.todaySalt /
                                                              1000)
                                                          : (state.weeklySalt /
                                                              1000)),
                                                      style:
                                                          GoogleFonts.notoSans(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color:
                                                            AppColors.secondary,
                                                      ),
                                                    ),
                                                    const Gap(8),
                                                    Text(
                                                      "Total Garam",
                                                      style: context
                                                          .textTheme.bodyLarge
                                                          ?.copyWith(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 2,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              );
                            } else if (state is GetHistoryLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return const Center(
                                child: Text('Error loading data'),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),

                  // Today's Scanned Products Section
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
                  BlocBuilder<HistoryCubit, HistoryState>(
                    builder: (context, state) {
                      if (state is GetHistoryLoading) {
                        return const SliverToBoxAdapter(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (state is GetHistorySuccess) {
                        final todayProducts = state.todayScannedProducts;
                        if (todayProducts.isEmpty) {
                          return SliverToBoxAdapter(
                            child: Center(
                              child: Text(
                                'Tidak ada produk yang dipindai hari ini',
                                style: context.textTheme.bodyLarge,
                              ),
                            ),
                          );
                        } else {
                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: ScanItem(
                                    data: todayProducts[index],
                                  ),
                                );
                              },
                              childCount: todayProducts.length,
                            ),
                          );
                        }
                      } else {
                        return const SliverToBoxAdapter(
                          child: Center(
                            child: Text('Tidak ada data'),
                          ),
                        );
                      }
                    },
                  ),

                  // Weekly Grouped Products Section
                  BlocBuilder<HistoryCubit, HistoryState>(
                    builder: (context, state) {
                      if (state is GetHistorySuccess) {
                        final weeklyProducts = state.weeklyGroupedProducts;

                        // Create a list of widgets for weekly grouped products
                        final weeklyWidgets =
                            weeklyProducts.entries.map((entry) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Week header
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 10),
                                child: Text(
                                  entry.key, // Week range label
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              // Products for this week
                              ...entry.value
                                  .map((product) => Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 12),
                                        child: ScanItem(data: product),
                                      ))
                                  .toList(),
                            ],
                          );
                        }).toList();

                        return SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: weeklyWidgets,
                          ),
                        );
                      }
                      return const SliverToBoxAdapter(
                        child: SizedBox.shrink(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String formatAngka(double nilai) {
    if (nilai == nilai.toInt()) {
      return nilai.toInt().toString();
    }

    return nilai.toStringAsFixed(1);
  }
}
