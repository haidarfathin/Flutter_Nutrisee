import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_button.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/core/widgets/app_textfield.dart';
import 'package:nutrisee/gen/assets.gen.dart';
import 'package:nutrisee/ui/auth/widget/diebetisi_radio.dart';

class CountBmiScreen extends StatefulWidget {
  const CountBmiScreen({super.key});

  @override
  State<CountBmiScreen> createState() => _CountBmiScreenState();
}

class _CountBmiScreenState extends State<CountBmiScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedGender;
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController waistController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBG,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text(
              "Hitung BMI",
            ),
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 24, right: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gap(20),
                    Row(
                      children: [
                        Expanded(
                          child: DiabetisiRadio(
                            image: Assets.images.icMale.image(),
                            title: "Pria",
                            isSelected: _selectedGender == "pria",
                            onTap: () =>
                                setState(() => _selectedGender = "pria"),
                          ),
                        ),
                        Gap(20),
                        Expanded(
                          child: DiabetisiRadio(
                            image: Assets.images.icFemale.image(),
                            title: "Wanita",
                            isSelected: _selectedGender == "wanita",
                            onTap: () =>
                                setState(() => _selectedGender = "wanita"),
                          ),
                        ),
                      ],
                    ),
                    Gap(20),
                    AppTextField(
                      keyboardType: TextInputType.number,
                      title: "Tinggi Badan",
                      hint: "000",
                      controller: heightController,
                      endIcon: Text(
                        "cm",
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: AppColors.textGray,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field ini harus diisi';
                        }
                        return null;
                      },
                    ),
                    const Gap(12),
                    AppTextField(
                      keyboardType: TextInputType.number,
                      title: "Berat Badan",
                      hint: "000",
                      controller: weightController,
                      endIcon: Text(
                        "kg",
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: AppColors.textGray,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field ini harus diisi';
                        }
                        return null;
                      },
                    ),
                    Gap(12),
                    AppTextField(
                      keyboardType: TextInputType.number,
                      title: "Lingkar Pinggang",
                      hint: "000",
                      controller: waistController,
                      endIcon: Text(
                        "cm",
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: AppColors.textGray,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: AppButton(
                    onPressed: () {
                      double height =
                          double.tryParse(heightController.text) ?? 0.0;
                      double weight =
                          double.tryParse(weightController.text) ?? 0.0;
                      double waist =
                          double.tryParse(waistController.text) ?? 0.0;
                      var bmiResult = calculateBMI(height, weight);
                      var whrResult;
                      if (waistController.text != "") {
                        whrResult = calculateWHR(waist, height);
                      }
                      context.push(
                        '/result-bmi',
                        extra: BMI(
                          useImage: false,
                          isMale: _selectedGender == "pria" ? true : false,
                          height: height,
                          weight: weight,
                          waist: waist,
                          bmiResult: bmiResult,
                          whrResult: whrResult,
                        ),
                      );
                    },
                    caption: "Hitung BMI",
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  double roundDouble(double value, int places) {
    double mod = pow(10.0, places).toDouble();
    return ((value * mod).round().toDouble() / mod);
  }

  double calculateBMI(double height, double weight) {
    var heightMeter = height / 100;
    var heightKuadrat = heightMeter * heightMeter;
    var bmi = weight / heightKuadrat;
    return roundDouble(bmi, 1);
  }

  double calculateWHR(double waist, double height) {
    var whr = waist / height;
    return whr.ceilToDouble();
  }
}

class BMI {
  bool useImage;
  double? bmiResult;
  String? imagePath;
  bool isMale;
  double height;
  double weight;
  double? waist;
  double? whrResult;

  BMI({
    required this.useImage,
    this.bmiResult,
    this.imagePath,
    required this.isMale,
    required this.height,
    required this.weight,
    this.waist,
    this.whrResult,
  });
}
