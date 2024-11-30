import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrisee/core/data/model/firestore/user_data.dart';
import 'package:nutrisee/core/data/model/product_nutrition.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_alert_dialog.dart';
import 'package:nutrisee/core/widgets/app_button.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/gen/assets.gen.dart';
import 'package:nutrisee/ui/scan_product/bloc/scan_product_cubit.dart';
import 'package:nutrisee/ui/scan_product/screen/detail_result_screen.dart';
import 'package:nutrisee/ui/scan_product/utils/nutrition_utils.dart';
import 'package:nutrisee/ui/scan_product/widget/examination_card.dart';
import 'package:nutrisee/ui/scan_product/widget/medical_card.dart';
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
                height: 450,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: BlocBuilder<ScanProductCubit, ScanProductState>(
                  builder: (context, state) {
                    log("Current state: $state");
                    if (state is AnalyzeProductLoading ||
                        state is GetProfileLoading) {
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
                          state.userData,
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
                    } else {
                      return const Center(
                        child: Text('No data'),
                      );
                    }
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
  UserData userData,
) {
  double garam = (nutrition.natrium! * nutrition.sajianPerKemasan!) / 1000;
  double gula = nutrition.sugar! * nutrition.sajianPerKemasan!.toDouble();
  double lemak = (nutrition.saturatedFat!.toDouble() *
          nutrition.sajianPerKemasan!.toDouble()) /
      10;
  bool userHasDiabetes = userData.hasDiabetes;
  bool userHasHipertensi = userData.hasHipertensi;
  double tdeeUser = userData.tdee ?? 0;

  return Padding(
    padding: const EdgeInsets.all(20),
    child: CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        if (userHasHipertensi)
          SliverToBoxAdapter(
            child: Column(
              children: [
                MedicalCard(
                  text: "Penderita Hipertensi",
                  backgroundColor: Colors.red.shade400,
                  foregroundColor: Colors.white,
                ),
                IconButton(
                  onPressed: () {
                    context.showCustomDialog(
                      content: infoContentDialog(
                        context: context,
                        onConfirm: () => context.pop(),
                        title: "Batas konsumsi garam harian < 1.5gr",
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.info_outline_rounded,
                    color: Colors.white,
                  ),
                  color: Colors.red.shade800,
                )
              ],
            ),
          )
        else if (userHasDiabetes)
          SliverToBoxAdapter(
            child: Row(
              children: [
                Expanded(
                  child: MedicalCard(
                    text: "Penderita Diabetes",
                    backgroundColor: Colors.orange.shade500,
                    foregroundColor: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.showCustomDialog(
                      content: infoContentDialog(
                        context: context,
                        onConfirm: () => context.pop(),
                        title: "Batas konsumsi gula harian < 25gr",
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.info_rounded,
                    size: 30,
                  ),
                  color: Colors.black,
                )
              ],
            ),
          )
        else
          SliverToBoxAdapter(
            child: Container(),
          ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 14),
            child: ExaminationCard(
              nutritionData: nutrition,
              hasHipertensi: userHasHipertensi,
              hasDiabetes: userHasDiabetes,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NutritionContainer(
                  kandungan: gula,
                  title: "Gula",
                ),
                NutritionContainer(
                  kandungan: lemak.toDouble(),
                  title: "Lemak Jenuh",
                ),
                NutritionContainer(
                  kandungan: garam,
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
                        NutritionUtils.stopTTS();
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
                        NutritionUtils.stopTTS();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailResultScreen(
                              nutritionData: nutrition,
                              imageFile: imageFile,
                              hasDiabetes: userData.hasDiabetes ?? false,
                              hasHipertensi: userData.hasHipertensi ?? false,
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
