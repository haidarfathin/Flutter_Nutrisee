import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:nutrisee/core/data/model/firestore/scanned_products.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/core/widgets/app_theme.dart';
import 'package:nutrisee/ui/history/cubit/history_cubit.dart';
import 'package:nutrisee/ui/home/widget/item_scan.dart';
import 'package:nutrisee/ui/menu_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final cubit = HistoryCubit();

  @override
  void initState() {
    super.initState();
    cubit.getUserHistory();
  }

  List<ScannedProduct> _getTodayScannedProducts(List<ScannedProduct> products) {
    final today = DateTime.now();
    return products.where((product) {
      return product.timeStamp.year == today.year &&
          product.timeStamp.month == today.month &&
          product.timeStamp.day == today.day;
    }).toList();
  }

  List<ScannedProduct> _getPreviousScannedProducts(
      List<ScannedProduct> products) {
    final today = DateTime.now();
    return products.where((product) {
      return !(product.timeStamp.year == today.year &&
          product.timeStamp.month == today.month &&
          product.timeStamp.day == today.day);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const MenuScreen(
                      screen: 0,
                    )));
        return false;
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
                        child: BlocBuilder<HistoryCubit, HistoryState>(
                          builder: (context, state) {
                            if (state is GetHistorySuccess) {
                              return Row(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${state.totalScanned}",
                                          style: context.textTheme.displayLarge
                                              ?.copyWith(
                                            color: AppColors.primary,
                                            fontSize: 36,
                                          ),
                                        ),
                                        Text(
                                          "Scan",
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
                                      Text(
                                        "Produk dipindai minggu ini",
                                        style: context.textTheme.bodyLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11),
                                      ),
                                      const Gap(10),
                                      Row(
                                        children: [
                                          Container(
                                            width: 80,
                                            padding: const EdgeInsets.all(10),
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
                                                  offset: const Offset(1, 3),
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${state.totalHighSugar}",
                                                  style: context
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w900,
                                                    color: AppColors.secondary,
                                                  ),
                                                ),
                                                Text(
                                                  "Gula Tinggi",
                                                  style: context
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
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
                                          const Gap(14),
                                          Container(
                                            width: 80,
                                            padding: const EdgeInsets.all(10),
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
                                                  offset: const Offset(1, 3),
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${state.totalHighNatrium}",
                                                  style: context
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w900,
                                                    color: AppColors.secondary,
                                                  ),
                                                ),
                                                Text(
                                                  "Garam Tinggi",
                                                  style: context
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
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
                        final todayProducts =
                            _getTodayScannedProducts(state.scannedProduct);
                        if (todayProducts.isEmpty) {
                          return SliverToBoxAdapter(
                            child: Center(
                              child: Text('No products scanned today'),
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
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Text(
                        "Hari Sebelumnya",
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
                        final previousProducts =
                            _getPreviousScannedProducts(state.scannedProduct);
                        if (previousProducts.isEmpty) {
                          return const SliverToBoxAdapter(
                            child: Center(
                              child: Text('No products scanned previously'),
                            ),
                          );
                        } else {
                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: ScanItem(
                                    data: previousProducts[index],
                                  ),
                                );
                              },
                              childCount: previousProducts.length,
                            ),
                          );
                        }
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
