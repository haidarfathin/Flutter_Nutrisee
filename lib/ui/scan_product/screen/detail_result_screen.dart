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
import 'package:nutrisee/ui/history/screen/history_screen.dart';
import 'package:nutrisee/ui/menu_screen.dart';
import 'package:nutrisee/ui/scan_product/bloc/scan_product_cubit.dart';
import 'package:nutrisee/ui/scan_product/widget/nutrition_container.dart';
import 'package:nutrisee/ui/scan_product/widget/tips_card.dart';

class DetailResultScreen extends StatefulWidget {
  final ProductNutrition nutritionData;
  final XFile imageFile;
  const DetailResultScreen({
    super.key,
    required this.nutritionData,
    required this.imageFile,
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
    int garam = widget.nutritionData.natrium?.toInt() ?? 0;
    int gula = widget.nutritionData.sugar?.toInt() ?? 0;
    int sajian = widget.nutritionData.sajianPerKemasan?.toInt() ?? 0;
    int lemak = widget.nutritionData.saturatedFat?.toInt() ?? 0;
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
                        fontSize: 16,
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
                        child: examineNutriScore(
                          garam,
                          gula,
                          lemak,
                          sajian,
                        ),
                      ),
                      const Gap(12),
                      examineNutritionTitle(garam, gula, sajian) !=
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
                                      examineNutritionTitle(
                                          garam, gula, sajian),
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
                                      color: AppColors.orangeSwatch.shade400,
                                    ),
                                    const Gap(8),
                                    Text(
                                      examineNutritionTitle(
                                          garam, gula, sajian),
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
                        kandungan: widget.nutritionData.natrium!.toDouble() *
                            widget.nutritionData.sajianPerKemasan!,
                        title: "Garam",
                      ),
                    ],
                  ),
                  const Gap(20),
                  Text(
                    "Saran dari NutriseeAI",
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
                      examineDescription(
                        examineNutritionTitle(
                          garam,
                          gula,
                          sajian,
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
                          context.showCustomDialog(
                            content: loadingContentDialog(
                                context: context, message: "Menyimpan produk"),
                          );
                        } else if (state is ProductAddedSuccess) {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MenuScreen(
                                screen: 1,
                              ),
                            ),
                          );
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
                                  score: examineNutriScoreString(
                                      garam, gula, lemak, sajian),
                                  natrium: garam.toDouble(),
                                  sugar: gula.toDouble(),
                                  fat: lemak.toDouble(),
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

String examineNutritionTitle(
  int garamValue,
  int gulaValue,
  int sajian,
) {
  double garam = garamValue / 1000.0 * sajian;
  double gula = gulaValue.toDouble() * sajian;

  double garamBatas = 2.0;
  double gulaBatas = 50.0;
  double proporsiGaram = garam / garamBatas;
  double proporsiGula = gula / gulaBatas;

  if (proporsiGaram > proporsiGula) {
    if (proporsiGaram >= 0.25) {
      return "Kandungan Garam Tinggi";
    } else {
      return "Produk Aman Dikonsumsi";
    }
  } else if (proporsiGula > proporsiGaram) {
    if (proporsiGula >= 0.25) {
      return "Kandungan Gula Tinggi";
    } else {
      return "Produk Aman Dikonsumsi";
    }
  } else {
    return "Produk Aman Dikonsumsi";
  }
}

Widget examineNutriScore(int garam, int gula, int lemak, int sajian) {
  var garamSajian = garam * sajian;
  var gulaSajian = gula * sajian;
  var lemakSajian = lemak * sajian;
  if ((garamSajian / 1000) < gulaSajian) {
    if (gulaSajian <= 5 && lemakSajian <= 1) {
      return Assets.images.icScoreA.image();
    } else if (gulaSajian > 5 && gulaSajian <= 10 && lemakSajian <= 2) {
      return Assets.images.icScoreB.image();
    } else if (gulaSajian > 10 && gulaSajian <= 15 && lemakSajian <= 3) {
      return Assets.images.icScoreC.image();
    } else {
      return Assets.images.icScoreD.image();
    }
  } else {
    if (garamSajian <= 500) {
      return Assets.images.icScoreA.image();
    } else if (garamSajian > 500 && garamSajian <= 1000) {
      return Assets.images.icScoreB.image();
    } else if (garamSajian > 1000 && garamSajian <= 1500) {
      return Assets.images.icScoreC.image();
    } else {
      return Assets.images.icScoreD.image();
    }
  }
}

String examineNutriScoreString(int garam, int gula, int lemak, int sajian) {
  var garamSajian = garam * sajian;
  var gulaSajian = gula * sajian;
  var lemakSajian = lemak * sajian;
  if ((garamSajian * sajian) / 1000 < gulaSajian) {
    if (gulaSajian <= 5 && lemakSajian <= 1) {
      return "A";
    } else if (gulaSajian > 5 && gulaSajian <= 10 && lemakSajian <= 2) {
      return "B";
    } else if (gulaSajian > 10 && gulaSajian <= 15 && lemakSajian <= 3) {
      return "C";
    } else {
      return "D";
    }
  } else {
    if (garamSajian <= 500) {
      return "A";
    } else if (garamSajian > 500 && garamSajian <= 1000) {
      return "B";
    } else if (garamSajian > 1000 && garamSajian <= 1500) {
      return "C";
    } else {
      return "D";
    }
  }
}

String examineDescription(String title, int garam, int gula, int sajian) {
  var garamSajian = garam * sajian;
  var gulaSajian = gula * sajian;
  double persamaanGaram = roundDouble(garamSajian / 2000, 1);
  double persamaanGula = roundDouble((gulaSajian / 15), 1);

  if (title == "Kandungan Gula Tinggi") {
    return "$gulaSajian gram gula setara dengan $persamaanGula sdm. Mengonsumsi $gulaSajian gram gula sudah mencapai ${((gulaSajian / 50) * 100).toInt()}% dari batas asupan gula harian yang direkomendasikan oleh Kementrian Keseharan Republik Indonesia (50 gram untuk wanita, 65 gram untuk pria). Mengonsumsi gula berlebihan dapat meningkatkan risiko terkena diabetes.";
  } else if (title == "Kandungan Garam Tinggi") {
    return "$garamSajian mg garam setara dengan $persamaanGaram sdt. Mengonsumsi $garamSajian mg garam sudah mencapai ${((garamSajian / 2000) * 100).toInt()}% dari batas asupan gula harian yang direkomendasikan oleh Kementrian Keseharan Republik Indonesia. Mengonsumsi garam berlebihan dapat meningkatkan risiko terkena hipertensi.";
  } else {
    return "Produk ini mengandung $garamSajian mg garam dan $gulaSajian gr gula dimana tergolong cukup aman dikonsumsi. Namun, tetap jaga asupan gula dan garam dari sumber lain untuk mengurangi risiko terkena penyakit tidak menular seperti diabetes dan hipertensi.";
  }
}

double roundDouble(double value, int places) {
  double mod = pow(10.0, places).toDouble();
  return ((value * mod).round().toDouble() / mod);
}
