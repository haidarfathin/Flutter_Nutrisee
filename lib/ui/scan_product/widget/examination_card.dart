import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrisee/core/data/model/product_nutrition.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/ui/scan_product/utils/nutrition_utils.dart';

class ExaminationCard extends StatefulWidget {
  final ProductNutrition nutritionData;
  final bool hasHipertensi;
  final bool hasDiabetes;
  const ExaminationCard({
    super.key,
    required this.nutritionData,
    required this.hasHipertensi,
    required this.hasDiabetes,
  });

  @override
  State<ExaminationCard> createState() => _ExaminationCardState();
}

class _ExaminationCardState extends State<ExaminationCard> {
  String kandungan = "";
  double nilaiKandungan = 0.0;
  String persamaan = "";

  final FlutterTts textToSpeech = FlutterTts();

  speak(String text) async {
    await textToSpeech.setLanguage("id");
    await textToSpeech.setPitch(1);
    await textToSpeech.setVolume(1);
    await textToSpeech.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    double gula = widget.nutritionData.sugar?.toDouble() ?? 0;
    double garam = widget.nutritionData.natrium?.toDouble() ?? 0;
    double lemak = widget.nutritionData.saturatedFat?.toDouble() ?? 0;
    double sajian = widget.nutritionData.sajianPerKemasan?.toDouble() ?? 0;

    if (gula * sajian > (garam * sajian / 1000)) {
      setState(() {
        kandungan = "Gula";
        nilaiKandungan = gula * sajian;
        persamaan = "${(gula * sajian / 15).ceil()} sdm";
      });
    } else {
      setState(() {
        kandungan = "Garam";
        nilaiKandungan = garam * sajian / 1000;
        persamaan = "${((garam * sajian / 1000) / 5).ceil()} sdt";
      });
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 1,
              child: NutritionUtils.examineImage(
                garam,
                gula,
                sajian,
                widget.hasHipertensi,
                widget.hasDiabetes,
              ),
            ),
            const Gap(14),
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    NutritionUtils.examineNutritionTitle(
                      garam,
                      gula,
                      sajian,
                      widget.hasHipertensi,
                      widget.hasDiabetes,
                    ),
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    NutritionUtils.examineNutritionTitle(
                              garam,
                              gula,
                              sajian,
                              widget.hasHipertensi,
                              widget.hasDiabetes,
                            ) !=
                            "Produk Aman Dikonsumsi"
                        ? "Kandungan $kandungan pada produk ini "
                            "sebesar ${nilaiKandungan.toInt()} gr ($persamaan)!"
                        : "Produk ini mengandung $nilaiKandungan $kandungan yang tergolong "
                            "cukup rendah untuk dikonsumsi. Tetap jaga asupan gula "
                            "dan garam anda.",
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontSize: 9,
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  String chooseGram(String kandungan) {
    if (kandungan == "Garam") {
      return "mg";
    } else {
      return "gr";
    }
  }
/*
  Widget examineImage(int garamValue, int gulaValue, int sajian) {
    double garam = (garamValue / 1000.0) * sajian;
    double gula = gulaValue.toDouble() * sajian;

    String title = examineNutritionTitle(garamValue, gulaValue, sajian);

    if (title == "Kandungan Garam Tinggi") {
      if (garam > 1.5 && garam <= 2.0) {
        Vibration.vibrate(pattern: [500, 1000, 500, 1000]);
        String speakText =
            "Kandungan Garam produk ini cukup tinggi, yaitu $nilaiKandungan gram, saya sarankan untuk tidak mengonsumsi ini berlebihan";
        speak(speakText);
        return Assets.images.scoreC.image();
      } else if (garam > 2.0) {
        Vibration.vibrate(pattern: [500, 2000, 500, 2000, 500, 2000]);
        String speakText =
            "Kandungan Garam produk ini sangat tinggi, yaitu $nilaiKandungan gram, saya sarankan untuk tidak mengonsumsi ini dan mengganti pilihan produk yang lebih sehat";
        speak(speakText);
        return Assets.images.scoreC.image();
      } else if (garam > 1.0 && garam <= 1.5) {
        return Assets.images.scoreB.image();
      } else {
        return Assets.images.scoreA.image();
      }
    } else if (title == "Kandungan Gula Tinggi") {
      if (gula > 6.0 && gula <= 12.0) {
        Vibration.vibrate(pattern: [500, 1000, 500, 1000]);
        String speakText =
            "Kandungan Gula produk ini cukup tinggi, yaitu ${nilaiKandungan.toInt()} gram, saya sarankan untuk tidak mengonsumsi ini berlebihan";
        speak(speakText);
        return Assets.images.scoreC.image();
      } else if (gula > 12.0) {
        Vibration.vibrate(pattern: [500, 2000, 500, 2000, 500, 2000]);
        String speakText =
            "Kandungan Gula produk ini sangat tinggi, yaitu $nilaiKandungan gram, saya sarankan untuk tidak mengonsumsi ini dan mengganti pilihan produk yang lebih sehat";
        speak(speakText);
        return Assets.images.scoreD.image();
      } else if (gula > 0.5 && gula <= 6.0) {
        return Assets.images.scoreB.image();
      } else {
        return Assets.images.scoreA.image();
      }
    } else {
      return Assets.images.icApprove.image();
    }
  }

  String examineNutritionTitle(
    int garamValue,
    int gulaValue,
    int sajian,
  ) {
    double garam = (garamValue * sajian) / 1000.0;
    double gula = gulaValue.toDouble() * sajian;

    double proporsiGaram = garam / 2;
    double proporsiGula = gula / 50;
    double persamaanGaram = roundDouble((garamValue * sajian) / 2000, 1);
    double persamaanGula = roundDouble((gulaValue / 15), 1);

    if (proporsiGaram > proporsiGula) {
      if (proporsiGaram >= 0.25) {
        kandungan = "Garam";
        nilaiKandungan = garam;
        persamaan = "${persamaanGaram.toInt()} sdt";
        return "Kandungan Garam Tinggi";
      } else {
        nilaiKandungan = gula;
        return "Produk Aman Dikonsumsi";
      }
    } else if (proporsiGula > proporsiGaram) {
      if (proporsiGula >= 0.25) {
        kandungan = "Gula";
        nilaiKandungan = gula;
        persamaan = "${persamaanGula.toInt()} sdm";
        return "Kandungan Gula Tinggi";
      } else {
        nilaiKandungan = gula;
        return "Produk Aman Dikonsumsi";
      }
    } else {
      nilaiKandungan = gula;
      return "Produk Aman Dikonsumsi";
    }
  }

*/
}
