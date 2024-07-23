import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_button.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/core/widgets/app_dropdown.dart';
import 'package:nutrisee/core/widgets/app_radio.dart';
import 'package:nutrisee/core/widgets/app_textfield.dart';
import 'package:intl/intl.dart';

class CountCaloriesScreen extends StatefulWidget {
  const CountCaloriesScreen({super.key});

  @override
  State<CountCaloriesScreen> createState() => _CountCaloriesScreenState();
}

class _CountCaloriesScreenState extends State<CountCaloriesScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedGender;
  String? levelAktivitas;
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBG,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text(
              "Hitung Kalori Harian",
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Jenis Kelamin",
                        style: context.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textBlack),
                      ),
                    ),
                    const Gap(8),
                    Row(
                      children: [
                        Expanded(
                          child: AppRadioButton(
                            title: "Laki-laki",
                            isSelected: _selectedGender == "pria",
                            onTap: () =>
                                setState(() => _selectedGender = "pria"),
                          ),
                        ),
                        const Gap(20),
                        Expanded(
                          child: AppRadioButton(
                            title: "Perempuan",
                            isSelected: _selectedGender == "wanita",
                            onTap: () =>
                                setState(() => _selectedGender = "wanita"),
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
                    const Gap(20),
                    AppDropdown(
                      title: "Level Aktivitas",
                      hint: "Pilih Level Aktivitas",
                      startIcon: Ionicons.walk,
                      textHintColor: Colors.green,
                      onSelected: (value) {
                        setState(() {
                          levelAktivitas = value;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          levelAktivitas = value;
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          value: '1',
                          child: Text(
                            "Minimal, pekerja kantoran",
                            style: context.textTheme.bodyLarge?.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DropdownMenuItem(
                          value: '2',
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Aktivitas Ringan",
                                style: context.textTheme.bodyLarge?.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Gap(4),
                              Text(
                                "Olahraga 1-2 kali/minggu",
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: AppColors.textBlack,
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: '3',
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Aktivitas Sedang",
                                style: context.textTheme.bodyLarge?.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Gap(4),
                              Text(
                                "Olahraga 3-5 kali/minggu",
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: AppColors.textBlack,
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: '4',
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Aktivitas Berat",
                                style: context.textTheme.bodyLarge?.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Gap(4),
                              Text(
                                "Olahraga 6-7 kali/minggu",
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: AppColors.textBlack,
                                  fontSize: 8,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: '5',
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Aktivitas Ekstrem",
                                style: context.textTheme.bodyLarge?.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Gap(4),
                              Text(
                                "Olahraga 2 kali sehari/lebih",
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: AppColors.textBlack,
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: AppButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        double height =
                            double.tryParse(heightController.text) ?? 0.0;
                        double weight =
                            double.tryParse(weightController.text) ?? 0.0;
                        DateTime birthDate = DateFormat('dd-MM-yyyy')
                            .parse(birthDateController.text);
                        int age = DateTime.now().year - birthDate.year;
                        if (DateTime.now().month < birthDate.month ||
                            (DateTime.now().month == birthDate.month &&
                                DateTime.now().day < birthDate.day)) {
                          age--;
                        }
                        Map<String, double> bmrValue = calculateBMR(
                          _selectedGender ?? "",
                          height,
                          weight,
                          age,
                          levelAktivitas ?? "1",
                        );
                        log(bmrValue.toString());
                        log(
                          "${_selectedGender.toString()},${heightController.text}+${weightController.text}+${birthDateController.text}+${levelAktivitas.toString()}",
                        );

                        context.push(
                          '/result-calories',
                          extra: bmrValue,
                        );
                      }
                    },
                    caption: "Hitung Kalori",
                  ),
                ),
                const Gap(12),
              ],
            ),
          ),
        ],
      ),
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

Map<String, double> calculateBMR(
  String gender,
  double height,
  double weight,
  int age,
  String activityLevel,
) {
  double bmr;
  if (gender == "pria") {
    bmr = (10 * weight) + (6.25 * height) - (5 * age) + 5;
  } else {
    bmr = (10 * weight) + (6.25 * height) - (5 * age) - 161;
  }

  double activityMultiplier;
  switch (activityLevel) {
    case '1':
      activityMultiplier = 1.2;
      break;
    case '2':
      activityMultiplier = 1.375;
      break;
    case '3':
      activityMultiplier = 1.55;
      break;
    case '4':
      activityMultiplier = 1.725;
      break;
    case '5':
      activityMultiplier = 1.9;
      break;
    default:
      activityMultiplier = 1.2;
      break;
  }

  double tdee = bmr * activityMultiplier;
  return {
    'BMR': bmr,
    'TDEE': tdee,
  };
}
