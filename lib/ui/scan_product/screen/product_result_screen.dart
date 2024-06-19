import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrisee/core/data/model/product_nutrition.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_button.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/core/widgets/app_theme.dart';
import 'package:nutrisee/ui/scan_product/bloc/product_bloc.dart';
import 'package:nutrisee/ui/scan_product/screen/detail_result_screen.dart';
import 'package:nutrisee/ui/scan_product/widget/examination_card.dart';
import 'package:nutrisee/ui/scan_product/widget/nutrition_container.dart';

class ProductResultScreen extends StatefulWidget {
  final String imagePath;
  const ProductResultScreen({super.key, required this.imagePath});

  @override
  State<ProductResultScreen> createState() => _ProductResultScreenState();
}

class _ProductResultScreenState extends State<ProductResultScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductBloc(Gemini.instance)..add(AnalyzeProduct(widget.imagePath)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Hasil Analisa Produk"),
          scrolledUnderElevation: 0,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Image.file(File(widget.imagePath))],
              ),
              DraggableScrollableSheet(
                minChildSize: 0.18,
                maxChildSize: 0.55,
                builder: (BuildContext context, scrollController) {
                  return Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 20,
                        right: 20,
                      ),
                      child: BlocBuilder<ProductBloc, ProductState>(
                        builder: (context, state) {
                          if (state is AnalyzeProductLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is AnalyzeProductSuccess) {
                            log(state.productNutrition.toString());
                            return contentContainer(
                              context,
                              scrollController,
                              state.productNutrition,
                              widget.imagePath,
                            );
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
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget contentContainer(
  BuildContext context,
  ScrollController controller,
  ProductNutrition nutrition,
  String imagePath,
) {
  var garam = nutrition.natrium! * nutrition.sajianPerKemasan!;
  var gula = nutrition.sugar! * nutrition.sajianPerKemasan!;
  var lemak = nutrition.saturatedFat! * nutrition.sajianPerKemasan!;

  return CustomScrollView(
    controller: controller,
    slivers: [
      SliverToBoxAdapter(
        child: Center(
          child: Container(
            width: 100,
            height: 8,
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.grey.shade300,
            ),
          ),
        ),
      ),
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
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(top: AppTheme.marginHorizontal),
          child: Row(
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
                          imagePath: imagePath,
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
        ),
      )
    ],
  );
}
