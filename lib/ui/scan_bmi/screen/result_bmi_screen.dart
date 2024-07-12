import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_button.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/core/widgets/app_theme.dart';
import 'package:nutrisee/gen/assets.gen.dart';
import 'package:nutrisee/ui/menu_screen.dart';
import 'package:nutrisee/ui/profile/widget/gauge_bmi.dart';
import 'package:nutrisee/ui/scan_bmi/bloc/scan_bmi_bloc.dart';
import 'package:nutrisee/ui/scan_bmi/screen/count_bmi_screen.dart';

class ResultBmiScreen extends StatefulWidget {
  final BMI bmiData;
  const ResultBmiScreen({
    super.key,
    required this.bmiData,
  });

  @override
  State<ResultBmiScreen> createState() => _ResultBmiScreenState();
}

class _ResultBmiScreenState extends State<ResultBmiScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScanBmiBloc(Gemini.instance)
        ..add(
          AnalyzeBmi(
            widget.bmiData.bmiResult ?? 0.0,
            bmiCalculate(
              widget.bmiData.bmiResult ?? 0.0,
            ),
          ),
        ),
      child: BlocBuilder<ScanBmiBloc, ScanBmiState>(
        builder: (context, state) {
          String descriptionResult = "load";
          if (state is AnalyzeBmiLoading) {
            descriptionResult = "loading";
          } else if (state is AnalyzeBmiSuccess) {
            descriptionResult = state.analysis;
          } else if (state is AnalyzeBmiError) {
            descriptionResult = state.message;
          }

          return Scaffold(
            backgroundColor: AppColors.whiteBG,
            appBar: AppBar(
              backgroundColor: Colors.white,
              scrolledUnderElevation: 0,
              title: const Text("Hasil BMI"),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(
                    Icons.refresh,
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.marginHorizontal,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gap(20),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 170,
                        height: 170,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppColors.greenGradient,
                        ),
                      ),
                      widget.bmiData.useImage
                          ? CircleAvatar(
                              radius: 75,
                              backgroundColor:
                                  const Color.fromARGB(255, 224, 245, 225),
                              foregroundImage: FileImage(
                                File(
                                  widget.bmiData.imagePath!,
                                ),
                              ))
                          : Container(
                              width: 150,
                              height: 150,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green.shade100,
                              ),
                              child: widget.bmiData.isMale
                                  ? Assets.images.icMale.image(width: 120)
                                  : Assets.images.icFemale.image(width: 120),
                            ),
                    ],
                  ),
                  const Gap(18),
                  Text(
                    "Hasil Analisa",
                    style: context.textTheme.headlineLarge,
                  ),
                  descriptionResult == "loading"
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          ),
                        )
                      : suggestionCard(descriptionResult, context),
                  cardProfile(
                    context,
                    bmiValue: widget.bmiData.bmiResult ?? 0.0,
                    height: widget.bmiData.height,
                    weight: widget.bmiData.weight,
                    waist: widget.bmiData.waist,
                  ),
                  Gap(20),
                  AppButton(
                    onPressed: () {
                      context.go('/menu');
                    },
                    caption: "Kembali ke Beranda",
                    useIcon: false,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Container suggestionCard(String descriptionResult, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: AppColors.orangeGradient,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orange.shade100,
            ),
            child: Assets.images.icBulb.image(),
          ),
          Gap(12),
          Expanded(
            child: Text(
              descriptionResult,
              style: context.textTheme.bodyLarge?.copyWith(
                fontSize: 10,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }

  Container cardProfile(
    BuildContext context, {
    double? waist,
    required double bmiValue,
    required double height,
    required double weight,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xff404A40),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: "Body Mass Index: ",
                  style: context.textTheme.titleLarge?.copyWith(
                    color: Colors.green.shade200,
                  ),
                  children: [
                    TextSpan(
                      text: bmiCalculate(bmiValue),
                      style: context.textTheme.titleLarge?.copyWith(
                        color: AppColors.whiteBG,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Icon(
                  Ionicons.information_circle,
                  color: Colors.green.shade300,
                ),
              ),
            ],
          ),
          const Gap(12),
          const GaugeBmi(
            bmiValue: 24.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              itemData(
                context,
                "Berat",
                weight.toInt().toString(),
              ),
              itemData(
                context,
                "Tinggi",
                height.toInt().toString(),
              ),
              itemData(
                context,
                "Pinggang",
                waist == null || waist == 0 ? 'NULL' : waist.toInt().toString(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column itemData(
    BuildContext context,
    String title,
    String data,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.bodySmall?.copyWith(
            color: Colors.green.shade200,
          ),
        ),
        Text(
          data,
          style: context.textTheme.bodyLarge?.copyWith(
            color: AppColors.whiteBG,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  String bmiCalculate(double bmiValue) {
    if (bmiValue < 18.5) {
      return "UNDERWEIGHT";
    } else if (bmiValue >= 18.5 && bmiValue <= 24.9) {
      return "IDEAL";
    } else if (bmiValue >= 25.0 && bmiValue <= 29.9) {
      return "OVERWEIGHT";
    } else if (bmiValue >= 30.0) {
      return "OBESE";
    } else {
      return "INVALID BMI";
    }
  }
}
