import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';

class NutritionContainer extends StatelessWidget {
  final double kandungan;
  final String title;

  const NutritionContainer({
    super.key,
    required this.kandungan,
    required this.title,
  });

  double getBatasHarian(String title) {
    switch (title.toLowerCase()) {
      case 'gula':
        return 50.0;
      case 'garam':
        return 2.0;
      case 'lemak jenuh':
        return 3.0;
      default:
        return 100.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double batasHarian = getBatasHarian(title);
    final double proportionalHeight = (kandungan / batasHarian) * 150;

    return Column(
      children: [
        Container(
          alignment: Alignment.topCenter,
          width: 100,
          child: Text(
            title,
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 11,
              color: examineBackground(kandungan, title),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const Gap(8),
        SizedBox(
          width: MediaQuery.of(context).size.width / 3 - 30,
          height: 150,
          child: Stack(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: examineBackground(kandungan, title).withOpacity(0.5),
                ),
                child: Container(
                  height: proportionalHeight,
                  decoration: BoxDecoration(
                    color: examineBackground(kandungan, title),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      formatAngka(kandungan),
                      style: GoogleFonts.bebasNeue(
                        color: Colors.black54,
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  String formatAngka(double nilai) {
    if (nilai == nilai.toInt()) {
      return nilai.toInt().toString();
    }

    return nilai.toStringAsFixed(1);
  }

  Color examineBackground(double kandungan, String title) {
    if (title == "Gula") {
      if (kandungan >= 10 && kandungan < 15) {
        return Colors.orange.shade400;
      } else if (kandungan >= 15) {
        return Colors.red.shade400;
      } else {
        return Colors.green.shade400;
      }
    } else if (title == "Garam") {
      if (kandungan >= 0.2 && kandungan < 1) {
        return Colors.orange.shade400;
      } else if (kandungan >= 1) {
        return Colors.red.shade400;
      } else {
        return Colors.green.shade400;
      }
    } else if (title == "Lemak Jenuh") {
      if (kandungan >= 2 && kandungan < 3) {
        return Colors.orange.shade400;
      } else if (kandungan >= 3) {
        return Colors.red.shade400;
      } else {
        return Colors.green.shade400;
      }
    } else {
      return Colors.black;
    }
  }
}
