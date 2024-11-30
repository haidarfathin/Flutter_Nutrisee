import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:im_stepper/stepper.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_alert_dialog.dart';
import 'package:nutrisee/core/widgets/app_button.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/core/widgets/app_textfield.dart';
import 'package:nutrisee/core/widgets/app_theme.dart';
import 'package:nutrisee/core/widgets/app_radio.dart';
import 'package:nutrisee/gen/assets.gen.dart';
import 'package:nutrisee/ui/diabetes_risk/widget/questioner_card.dart';

class PaginatedDiabetesTest extends StatefulWidget {
  const PaginatedDiabetesTest({super.key});

  @override
  State<PaginatedDiabetesTest> createState() => _PaginatedDiabetesTestState();
}

class _PaginatedDiabetesTestState extends State<PaginatedDiabetesTest> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  String? _selectedGender;
  final ValueNotifier<bool?> _secondRelativeDiabetes =
      ValueNotifier<bool?>(null);
  final ValueNotifier<bool?> _firstRelativeDiabetes =
      ValueNotifier<bool?>(null);
  final ValueNotifier<bool?> _historyHighBloodGlucose =
      ValueNotifier<bool?>(null);
  final ValueNotifier<bool?> _consumeBloodPressureMedication =
      ValueNotifier<bool?>(null);
  final ValueNotifier<bool?> _frequentPhysicalActivty =
      ValueNotifier<bool?>(null);
  final ValueNotifier<bool?> _dailyConsumptionVeggies =
      ValueNotifier<bool?>(null);

  final List<String> lingkarPinggangOptions = [
    '< 80cm',
    '80-88cm',
    '89-93cm',
    '94-102cm',
    '> 102cm'
  ];
  String? selectedLingkarPinggang;

  List<StepWidget> steps() => [
        StepWidget(
          title: "Tentang Kamu",
          content: stepOne(context),
        ),
        StepWidget(
          title: "Kondisi kesehatan",
          content: stepTwo(context),
        ),
        StepWidget(
          title: "Gaya Hidup",
          content: stepThree(context),
        ),
      ];

  int activeStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverLayoutBuilder(
          builder: (context, constraints) {
            final scrolled = constraints.scrollOffset > 0;
            return SliverAppBar(
              title: const Text("Kalkulator Risiko Diabetes"),
              leading: IconButton(
                onPressed: () {
                  if (activeStep > 0) {
                    setState(() {
                      activeStep--;
                    });
                  } else {
                    context.pop();
                  }
                },
                icon: const Icon(
                  Ionicons.arrow_back,
                  color: AppColors.textBlack,
                ),
                splashRadius: 20,
              ),
              scrolledUnderElevation: 0,
              leadingWidth: 80,
              backgroundColor: scrolled ? Colors.white : Colors.transparent,
              pinned: true,
            );
          },
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: AppTheme.marginHorizontal,
                  right: AppTheme.marginHorizontal,
                  top: 20,
                  bottom: AppTheme.marginVertical,
                ),
                child: DotStepper(
                  dotCount: steps().length,
                  dotRadius: 12,
                  spacing: 30,
                  activeStep: activeStep,
                  shape: Shape.circle,
                  lineConnectorsEnabled: true,
                  tappingEnabled: true,
                  fixedDotDecoration: const FixedDotDecoration(
                    color: AppColors.grayBG,
                    strokeWidth: 5,
                    strokeColor: Colors.white,
                  ),
                  indicatorDecoration: const IndicatorDecoration(
                    color: AppColors.primary,
                    strokeWidth: 5,
                    strokeColor: Colors.white,
                  ),
                  lineConnectorDecoration: const LineConnectorDecoration(
                    color: AppColors.grayBG,
                    strokeWidth: 3,
                  ),
                ),
              ),
              Text(
                steps()[activeStep].title,
                style: context.textTheme.headlineLarge,
              ),
              const Gap(50),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.marginHorizontal,
            ),
            child: steps()[activeStep].content,
          ),
        ),
        bottomButton(context)
      ],
    ));
  }

  SliverFillRemaining bottomButton(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.marginHorizontal,
          vertical: AppTheme.marginVertical,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                activeStep >= 1
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: AppButton(
                            caption: "Kembali",
                            color: AppColors.ancientSwatch.shade100,
                            useIcon: false,
                            captionStyle: context.textTheme.titleLarge
                                ?.copyWith(color: AppColors.primary),
                            onPressed: () {
                              setState(() => activeStep--);
                            },
                          ),
                        ),
                      )
                    : Container(),
                Expanded(
                  child: AppButton(
                    onPressed: () {
                      if (activeStep == 2) {
                        var score = calculateRiskScore();
                        log("score: $score");
                        var percentage =
                            interpreterRiskPercentage(score, _selectedGender!);
                        context.push('/diabetes-risk-result', extra: {
                          'score': score,
                          'percent': percentage,
                        });
                      } else {
                        setState(() {
                          activeStep += 1;
                        });
                      }
                    },
                    caption: activeStep == 2 ? "Selesai" : "Lanjut",
                    useIcon: false,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget stepTwo(BuildContext context) {
    return Column(
      children: [
        QuestionerCard(
          selectedOptionNotifier: _secondRelativeDiabetes,
          onOptionsSelected: (isPositive) {
            setState(() {
              _secondRelativeDiabetes.value = isPositive;
            });
          },
          captions:
              "Apakah kakek, bibi, paman, atau sepupu pertama pernah didiagnosis Diabetes?",
          options: [
            QuestionerOptions(
              isPositive: true,
              label: "Ya",
            ),
            QuestionerOptions(
              isPositive: false,
              label: "Tidak",
            ),
          ],
        ),
        const Gap(12),
        QuestionerCard(
          selectedOptionNotifier: _firstRelativeDiabetes,
          onOptionsSelected: (isPositive) {
            setState(() {
              _firstRelativeDiabetes.value = isPositive;
            });
          },
          captions:
              "Apakah ayah, ibu, atau saudara kandung pernah didiagnosis Diabetes?",
          options: [
            QuestionerOptions(
              isPositive: true,
              label: "Ya",
            ),
            QuestionerOptions(
              isPositive: false,
              label: "Tidak",
            ),
          ],
        ),
        const Gap(12),
        QuestionerCard(
          selectedOptionNotifier: _historyHighBloodGlucose,
          onOptionsSelected: (isPositive) {
            setState(() {
              _historyHighBloodGlucose.value = isPositive;
            });
          },
          captions:
              "Apakah Anda pernah didiagnosis memiliki kadar glukosa darah yang tinggi?",
          options: [
            QuestionerOptions(
              isPositive: true,
              label: "Ya",
            ),
            QuestionerOptions(
              isPositive: false,
              label: "Tidak",
            ),
          ],
        ),
        const Gap(12),
        QuestionerCard(
          selectedOptionNotifier: _consumeBloodPressureMedication,
          onOptionsSelected: (isPositive) {
            setState(() {
              _consumeBloodPressureMedication.value = isPositive;
            });
          },
          captions: "Apakah Anda mengonsumsi obat untuk tekanan darah tinggi?",
          options: [
            QuestionerOptions(
              isPositive: true,
              label: "Ya",
            ),
            QuestionerOptions(
              isPositive: false,
              label: "Tidak",
            ),
          ],
        ),
      ],
    );
  }

  Widget stepThree(BuildContext context) {
    return Column(
      children: [
        QuestionerCard(
          selectedOptionNotifier: _frequentPhysicalActivty,
          onOptionsSelected: (isPositive) {
            setState(() {
              _frequentPhysicalActivty.value = isPositive;
            });
          },
          captions:
              "Apakah kamu berolahraga selama lebih dari 30 menit setiap hari?",
          options: [
            QuestionerOptions(
              isPositive: true,
              label: "Ya",
            ),
            QuestionerOptions(
              isPositive: false,
              label: "Tidak",
            ),
          ],
        ),
        const Gap(12),
        QuestionerCard(
          selectedOptionNotifier: _dailyConsumptionVeggies,
          onOptionsSelected: (isPositive) {
            setState(() {
              _dailyConsumptionVeggies.value = isPositive;
            });
          },
          captions: "Seberapa sering kamu mengkonsumsi sayur dan buah?",
          options: [
            QuestionerOptions(
              isPositive: true,
              label: "Sering",
            ),
            QuestionerOptions(
              isPositive: false,
              label: "Jarang",
            ),
          ],
        ),
        const Gap(12),
      ],
    );
  }

  Widget stepOne(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Jenis Kelamin",
                  style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600, color: AppColors.textBlack),
                ),
              ),
              const Gap(8),
              Row(
                children: [
                  Expanded(
                    child: AppRadioButton(
                      title: "Laki-laki",
                      isSelected: _selectedGender == "pria",
                      onTap: () => setState(() => _selectedGender = "pria"),
                    ),
                  ),
                  const Gap(20),
                  Expanded(
                    child: AppRadioButton(
                      title: "Perempuan",
                      isSelected: _selectedGender == "wanita",
                      onTap: () => setState(() => _selectedGender = "wanita"),
                    ),
                  ),
                ],
              ),
              const Gap(20),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
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
                  ),
                  const Gap(20),
                  Expanded(
                    child: AppTextField(
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
                  ),
                ],
              ),
              const Gap(20),
              AppTextField(
                title: "Tanggal lahir",
                hint: "dd-mm-YYYY",
                startIcon: Ionicons.calendar_outline,
                endIcon: Ionicons.chevron_forward,
                readOnlyField: true,
                controller: birthDateController,
                onTap: () => _selectDate(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field ini harus diisi';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        const Gap(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Berapa lingkar pinggang kamu?",
              style: context.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600, color: AppColors.textBlack),
            ),
            InkWell(
              onTap: () {
                context.showCustomDialog(
                  content: sizeContentDialog(
                    context: context,
                    title: "Cara Mengetahui Lingkar Pinggang",
                    onConfirm: () {
                      Navigator.pop(context);
                    },
                  ),
                );
              },
              child: const Icon(
                Icons.question_mark,
                size: 18,
                color: AppColors.secondary,
              ),
            )
          ],
        ),
        const Gap(8),
        Align(
          alignment: Alignment.topLeft,
          child: Wrap(
            spacing: 10.0,
            children: lingkarPinggangOptions.map((option) {
              return ChoiceChip(
                showCheckmark: false,
                elevation: 4,
                backgroundColor: AppColors.grayBG,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Colors.transparent),
                ),
                selectedColor: AppColors.ancientSwatch.shade200,
                label: Text(
                  option,
                  style: context.textTheme.bodyLarge?.copyWith(),
                ),
                selected: selectedLingkarPinggang == option,
                onSelected: (bool selected) {
                  setState(() {
                    selectedLingkarPinggang = selected ? option : '';
                  });
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.primary,
                onPrimary: AppColors.whiteBG,
                onSurface: AppColors.textBlack,
              ),
              textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
              ))),
          child: child!,
        );
      },
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime(3000),
    );
    if (pickedDate != null) {
      setState(() {
        birthDateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }

  int calculateRiskScore() {
    int score = 0;

    DateTime birthDate =
        DateFormat('dd-MM-yyyy').parse(birthDateController.text);
    int age = DateTime.now().year - birthDate.year;
    if (DateTime.now().month < birthDate.month ||
        (DateTime.now().month == birthDate.month &&
            DateTime.now().day < birthDate.day)) {
      age--;
    }
    if (age < 45) {
      score += 0;
    } else if (age >= 45 && age <= 54) {
      score += 2;
    } else if (age >= 55 && age < 64) {
      score += 3;
    } else {
      score += 4;
    }

    if (_selectedGender == 'pria') {
      if (selectedLingkarPinggang == "94-102cm") {
        score += 3;
      } else if (selectedLingkarPinggang == "> 102cm") {
        score += 4;
      }
    } else {
      if (selectedLingkarPinggang == "80-88cm") {
        score += 3;
      } else if (selectedLingkarPinggang == "< 80cm") {
        score += 0;
      } else {
        score += 4;
      }
    }

    double height = double.tryParse(heightController.text) ?? 0;
    double weight = double.tryParse(weightController.text) ?? 0;
    double bmi = weight / ((height / 100) * (height / 100));
    if (bmi > 30) {
      score += 3;
    } else if (bmi >= 25 && bmi <= 30) {
      score += 1;
    } else {
      score += 0;
    }

    if (_firstRelativeDiabetes.value == true) {
      score += 5;
    } else if (_secondRelativeDiabetes.value == true) {
      score += 3;
    } else {
      score += 0; // No history
    }

    if (_historyHighBloodGlucose.value == true) {
      score += 5;
    }
    if (_consumeBloodPressureMedication.value == true) {
      score += 2;
    }
    if (_frequentPhysicalActivty.value == false) {
      score += 2;
    }
    if (_dailyConsumptionVeggies.value == false) {
      score += 1;
    }

    return score;
  }
}

String interpreterRiskPercentage(
  int score,
  String sex,
) {
  if (sex == "pria") {
    if (score <= 8) {
      return "0.8%";
    } else if (score >= 9 && score <= 12) {
      return "2.6%";
    } else if (score >= 13 && score <= 20) {
      return "23.1%";
    } else if (score >= 21) {
      return "~50%";
    } else {
      return "Invalid";
    }
  } else {
    if (score <= 8) {
      return "0.4%";
    } else if (score >= 9 && score <= 12) {
      return "2.2%";
    } else if (score >= 13 && score <= 20) {
      return "14.1%";
    } else if (score >= 21) {
      return "~50%";
    } else {
      return "Invalid";
    }
  }
}

class StepWidget {
  final String title;
  final Widget content;

  StepWidget({
    required this.title,
    required this.content,
  });
}
