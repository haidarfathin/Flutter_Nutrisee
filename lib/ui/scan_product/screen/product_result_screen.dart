import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrisee/core/data/model/product_nutrition.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_button.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/core/widgets/app_theme.dart';
import 'package:nutrisee/gen/assets.gen.dart';
import 'package:nutrisee/ui/scan_product/bloc/scan_product_cubit.dart';
import 'package:nutrisee/ui/scan_product/screen/detail_result_screen.dart';
import 'package:nutrisee/ui/scan_product/widget/examination_card.dart';
import 'package:nutrisee/ui/scan_product/widget/nutrition_container.dart';

class ProductResultScreen extends StatefulWidget {
  final XFile imageFile;
  const ProductResultScreen({super.key, required this.imageFile});

  @override
  State<ProductResultScreen> createState() => _ProductResultScreenState();
}

class _ProductResultScreenState extends State<ProductResultScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ScanProductCubit()..analyzeProduct(widget.imageFile.path),
      child: Scaffold(
        backgroundColor: AppColors.black,
        appBar: AppBar(
          title: const Text("Hasil Analisa Produk"),
          scrolledUnderElevation: 0,
        ),
        body: SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Image.file(File(widget.imageFile.path))],
              ),
              Container(
                alignment: Alignment.center,
                height: 400,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: BlocBuilder<ScanProductCubit, ScanProductState>(
                  builder: (context, state) {
                    log("Current state: $state");
                    if (state is AnalyzeProductLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is AnalyzeProductSuccess) {
                      if (state.productNutrition.isNutritionFacts == true) {
                        log(state.productNutrition.toString());
                        return contentContainer(
                          context,
                          state.productNutrition,
                          widget.imageFile,
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Assets.images.icWarning
                                  .image(width: 60, height: 60),
                              const Gap(14),
                              Text(
                                "Tampaknya ini bukanlah gambar tabel nilai gizi, coba arahkan kamera ke tabel nilai gizi produk kemasan makanan dan minuman",
                                style: context.textTheme.titleMedium,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }
                    } else if (state is AnalyzeProductError) {
                      return Center(
                        child: Text(state.error),
                      );
                    }
                    return const Center(
                      child: Text('No data'),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget contentContainer(
  BuildContext context,
  ProductNutrition nutrition,
  XFile imageFile,
) {
  var garam = nutrition.natrium! * nutrition.sajianPerKemasan!;
  var gula = nutrition.sugar! * nutrition.sajianPerKemasan!;
  var lemak = nutrition.saturatedFat! * nutrition.sajianPerKemasan!;

  return Padding(
    padding: const EdgeInsets.all(20),
    child: CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: ExaminationCard(nutritionData: nutrition),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NutritionContainer(
                  kandungan: gula.toDouble(),
                  title: "Gula",
                ),
                NutritionContainer(
                  kandungan: lemak.toDouble(),
                  title: "Lemak Jenuh",
                ),
                NutritionContainer(
                  kandungan: garam.toDouble(),
                  title: "Garam",
                ),
              ],
            ),
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      onPressed: () {
                        context.pop();
                      },
                      caption: "Ulangi",
                      color: Colors.transparent,
                      border: Border.all(color: AppColors.primary, width: 3),
                      useIcon: false,
                      captionStyle: context.textTheme.bodyLarge?.copyWith(
                        color: AppColors.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: AppButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailResultScreen(
                              nutritionData: nutrition,
                              imageFile: imageFile,
                            ),
                          ),
                        );
                      },
                      caption: "Detail",
                      useIcon: false,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}
