import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:im_stepper/stepper.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_button.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/core/widgets/app_textfield.dart';
import 'package:nutrisee/core/widgets/app_theme.dart';
import 'package:nutrisee/core/widgets/app_radio.dart';
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
                      activeStep == 2
                          ? context.push("/diabetes-risk-result")
                          : setState(() => activeStep += 1);
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
          onOptionsSelected: () {
            setState(() {});
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
        )
      ],
    );
  }

  Widget stepThree(BuildContext context) {
    return const Column(
      children: [
        // QuestionerCard(),
        // Gap(20),
        // QuestionerCard(),
        // Gap(40),
        Placeholder()
      ],
    );
  }

  Column stepOne(BuildContext context) {
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
              onTap: () {},
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
}

class StepWidget {
  final String title;
  final Widget content;

  StepWidget({
    required this.title,
    required this.content,
  });
}
