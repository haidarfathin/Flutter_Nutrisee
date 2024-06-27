import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gap/gap.dart';
import 'package:nutrisee/core/data/model/product_nutrition.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/gen/assets.gen.dart';
import 'package:vibration/vibration.dart';

class ExaminationCard extends StatefulWidget {
  final ProductNutrition nutritionData;
  const ExaminationCard({
    super.key,
    required this.nutritionData,
  });

  @override
  State<ExaminationCard> createState() => _ExaminationCardState();
}

class _ExaminationCardState extends State<ExaminationCard> {
  String kandungan = "Gula";
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
    int gula = widget.nutritionData.sugar ?? 0;
    int garam = widget.nutritionData.natrium ?? 0;
    int sajian = widget.nutritionData.sajianPerKemasan ?? 0;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 1,
              child: InkWell(
                onTap: () {
                  String speakText =
                      "Kandungan gula ini sangat tinggi, yaitu $gula gram, saya sarankan untuk tidak mengonsumsi ini berlebihan";
                  speak(speakText);
                },
                child: examineImage(garam, gula, sajian),
              ),
            ),
            const Gap(8),
            Flexible(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    examineNutritionTitle(garam, gula, sajian),
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Gap(4),
                  Text(
                    examineNutritionTitle(garam, gula, sajian) !=
                            "Produk Aman Dikonsumsi"
                        ? "Kandungan $kandungan pada produk ini "
                            "sebesar ${nilaiKandungan}gr ($persamaan)!"
                        : "Produk ini mengandung $nilaiKandungan gula yang tergolong "
                            "cukup rendah untuk dikonsumsi. Tetap jaga asupan gula "
                            "dan garam anda.",
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontSize: 10,
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

  Widget examineImage(int garamValue, int gulaValue, int sajian) {
    double garam = (garamValue / 1000.0) * sajian;
    double gula = gulaValue.toDouble() * sajian;

    String title = examineNutritionTitle(garamValue, gulaValue, sajian);

    if (title == "Kandungan Garam Tinggi") {
      if (garam >= 0.5 && garam <= 1.0) {
        Vibration.vibrate(pattern: [500, 1000, 500, 1000]);
        return Assets.images.icWarning.image();
      } else if (garam > 1.0) {
        Vibration.vibrate(pattern: [500, 2000, 500, 2000, 500, 2000]);
        return Assets.images.icStop.image();
      } else {
        return Assets.images.icApprove.image();
      }
    } else if (title == "Kandungan Gula Tinggi") {
      if (gula >= 12.5 && gula <= 30.0) {
        Vibration.vibrate(pattern: [500, 1000, 500, 1000]);
        return Assets.images.icWarning.image();
      } else if (gula > 30.0) {
        Vibration.vibrate(pattern: [500, 2000, 500, 2000, 500, 2000]);
        return Assets.images.icStop.image();
      } else {
        return Assets.images.icApprove.image();
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
    double persamaanGula = roundDouble((gula / 12.5), 1);

    if (proporsiGaram > proporsiGula) {
      if (proporsiGaram >= 0.25) {
        kandungan = "Garam";
        nilaiKandungan = garam;
        persamaan = "$persamaanGaram sdt";
        return "Kandungan Garam Tinggi";
      } else {
        nilaiKandungan = gula;
        return "Produk Aman Dikonsumsi";
      }
    } else if (proporsiGula > proporsiGaram) {
      if (proporsiGula >= 0.25) {
        kandungan = "Gula";
        nilaiKandungan = gula;
        persamaan = "$persamaanGula sdt";
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
}

double roundDouble(double value, int places) {
  double mod = pow(10.0, places).toDouble();
  return ((value * mod).round().toDouble() / mod);
}
