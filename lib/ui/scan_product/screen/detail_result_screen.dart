import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrisee/core/data/model/product_nutrition.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_alert_dialog.dart';
import 'package:nutrisee/core/widgets/app_button.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/core/widgets/app_snackbar.dart';
import 'package:nutrisee/core/widgets/app_theme.dart';
import 'package:nutrisee/gen/assets.gen.dart';

//
import 'package:nutrisee/ui/scan_product/bloc/scan_product_cubit.dart';
import 'package:nutrisee/ui/scan_product/utils/nutrition_utils.dart';
import 'package:nutrisee/ui/scan_product/widget/nutrition_container.dart';
import 'package:nutrisee/ui/scan_product/widget/tips_card.dart';

class DetailResultScreen extends StatefulWidget {
  final ProductNutrition nutritionData;
  final bool hasHipertensi;
  final bool hasDiabetes;
  final XFile imageFile;
  const DetailResultScreen({
    super.key,
    required this.nutritionData,
    required this.imageFile,
    required this.hasHipertensi,
    required this.hasDiabetes,
  });

  @override
  State<DetailResultScreen> createState() => _DetailResultScreenState();
}

class _DetailResultScreenState extends State<DetailResultScreen> {
  bool isEdit = false;
  TextEditingController nameController =
      TextEditingController(text: "Produk Tanpa Nama");

  @override
  Widget build(BuildContext context) {
    double garam = widget.nutritionData.natrium?.toDouble() ?? 0;
    double gula = widget.nutritionData.sugar?.toDouble() ?? 0;
    double sajian = widget.nutritionData.sajianPerKemasan?.toDouble() ?? 0;
    double lemak = widget.nutritionData.saturatedFat?.toDouble() ?? 0;
    bool hasHipertensi = widget.hasHipertensi;
    bool hasDiabetes = widget.hasDiabetes;

    return Scaffold(
      backgroundColor: AppColors.whiteBG,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text("Detail Produk"),
            centerTitle: true,
            scrolledUnderElevation: 0,
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Image.file(
              File(widget.imageFile.path),
              fit: BoxFit.cover,
              height: 100,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.marginHorizontal,
                vertical: AppTheme.marginVertical,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: nameController,
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.start,
                      cursorColor: AppColors.secondary,
                      decoration: InputDecoration(
                        border: isEdit ? null : InputBorder.none,
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 2,
                          ),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(12),
                  Text(
                    "Nutriscore",
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      SizedBox(
                        height: 60,
                        child: NutritionUtils.getNutriScoreImage(
                          garam,
                          gula,
                          lemak,
                          sajian,
                          hasHipertensi,
                          hasDiabetes,
                        ),
                      ),
                      const Gap(12),
                      NutritionUtils.examineNutritionTitle(
                                garam,
                                gula,
                                sajian,
                                widget.hasHipertensi,
                                widget.hasDiabetes,
                              ) !=
                              "Produk Aman Dikonsumsi"
                          ? Expanded(
                              child: Container(
                                height: 50,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.orangeSwatch.shade100,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.info_rounded,
                                      color: AppColors.orangeSwatch.shade400,
                                    ),
                                    const Gap(8),
                                    Text(
                                      NutritionUtils.examineNutritionTitle(
                                        garam,
                                        gula,
                                        sajian,
                                        widget.hasHipertensi,
                                        widget.hasDiabetes,
                                      ),
                                      style:
                                          context.textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                        color: AppColors.orangeSwatch.shade400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Expanded(
                              child: Container(
                                height: 50,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green.shade100,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.info_rounded,
                                      color: Colors.green.shade900,
                                    ),
                                    const Gap(8),
                                    Text(
                                      NutritionUtils.examineNutritionTitle(
                                        garam,
                                        gula,
                                        sajian,
                                        widget.hasHipertensi,
                                        widget.hasDiabetes,
                                      ),
                                      style:
                                          context.textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                        color: Colors.green.shade900,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                    ],
                  ),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      NutritionContainer(
                        kandungan: widget.nutritionData.sugar!.toDouble() *
                            widget.nutritionData.sajianPerKemasan!,
                        title: "Gula",
                      ),
                      NutritionContainer(
                        kandungan:
                            widget.nutritionData.saturatedFat!.toDouble() *
                                widget.nutritionData.sajianPerKemasan!,
                        title: "Lemak Jenuh",
                      ),
                      NutritionContainer(
                        kandungan:
                            (widget.nutritionData.natrium! / 1000).toDouble() *
                                widget.nutritionData.sajianPerKemasan!,
                        title: "Garam",
                      ),
                    ],
                  ),
                  const Gap(20),
                  Text(
                    "Saran dari Glukosaw",
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(8),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Text(
                      NutritionUtils.examineDescription(
                        NutritionUtils.examineNutritionTitle(
                          garam,
                          gula,
                          sajian,
                          widget.hasHipertensi,
                          widget.hasDiabetes,
                        ),
                        garam,
                        gula,
                        sajian,
                      ),
                      style: context.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w500, fontSize: 11),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const Gap(20),
                  Text(
                    "Tips",
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(8),
                  const TipsCard(
                    imagePath: "assets/images/ic_running.png",
                    text:
                        "Dianjurkan untuk berolahraga minimal 30 menit setiap hari, seperti berjalan kaki, bersepeda, atau berenang.",
                  ),
                  const Gap(10),
                  const TipsCard(
                    imagePath: "assets/images/ic_veggies.png",
                    text:
                        "Konsumsi makanan kaya serat seperti sayur, buah, dan kacang-kacangan untuk membantu mengontrol kadar gula darah.",
                  ),
                  const Gap(10),
                  const TipsCard(
                    imagePath: "assets/images/ic_sleep.png",
                    text:
                        "Tidur yang cukup untuk membantu tubuh mengatur kadar gula darah.",
                  ),
                  const Gap(10),
                  const TipsCard(
                    imagePath: "assets/images/ic_water.png",
                    text:
                        "Minum air putih yang cukup untuk membantu tubuh mengeluarkan gula berlebih.",
                  ),
                  Gap(20),
                  BlocProvider(
                    create: (context) => ScanProductCubit(),
                    child: BlocConsumer<ScanProductCubit, ScanProductState>(
                      listener: (context, state) {
                        if (state is ProductAddLoading) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: loadingContentDialog(context: context),
                                );
                              });
                        } else if (state is ProductAddedSuccess) {
                          context.pop();
                          context.go('/history');
                        } else if (state is ProductAddError) {
                          Navigator.of(context).pop();
                          context.showSnackbar(state.error);
                        }
                      },
                      builder: (context, state) {
                        return AppButton(
                          onPressed: () {
                            bool isSugarHighest;
                            double gulaSajian = gula * sajian.toDouble();
                            double garamSajian = (garam / 1000) * sajian;

                            if (gulaSajian > garamSajian) {
                              isSugarHighest = true;
                            } else {
                              isSugarHighest = false;
                            }
                            context.read<ScanProductCubit>().saveScannedProduct(
                                  image: widget.imageFile,
                                  isSugarHighest: isSugarHighest,
                                  name: nameController.text,
                                  score: NutritionUtils.getNutriScoreString(
                                    garam,
                                    gula,
                                    lemak,
                                    sajian,
                                    hasHipertensi,
                                    hasDiabetes,
                                  ),
                                  salt: garam,
                                  sugar: gula,
                                  sajian: sajian,
                                  fat: lemak,
                                  timestamp: DateTime.now(),
                                );
                          },
                          caption: "Kembali ke Beranda",
                          useIcon: false,
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
    );
  }
}
