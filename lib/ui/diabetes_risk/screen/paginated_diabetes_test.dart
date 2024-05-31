import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_button.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/core/widgets/app_textfield.dart';
import 'package:nutrisee/ui/auth/widget/app_radio.dart';

class PaginatedDiabetesTest extends StatefulWidget {
  const PaginatedDiabetesTest({super.key});

  @override
  State<PaginatedDiabetesTest> createState() => _PaginatedDiabetesTestState();
}

class _PaginatedDiabetesTestState extends State<PaginatedDiabetesTest> {
  String? _selectedGender;
  final List<String> options = ['Option 1', 'Option 2', 'Option 3'];
  String selectedOption = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Langkah 1 dari 3",
            style: context.textTheme.bodyLarge,
          ),
          const Gap(12),
          Text(
            "Tentang Kamu",
            style: context.textTheme.displayLarge,
          ),
          const Gap(30),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Jenis Kelamin",
              style: context.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600, color: AppColors.textBlack),
            ),
          ),
          Gap(8),
          Row(
            children: [
              Expanded(
                child: AppRadioButton(
                  title: "Laki-laki",
                  isSelected: _selectedGender == "l",
                  onTap: () => setState(() => _selectedGender = "l"),
                ),
              ),
              Gap(20),
              Expanded(
                child: AppRadioButton(
                  title: "Perempuan",
                  isSelected: _selectedGender == "w",
                  onTap: () => setState(() => _selectedGender = "w"),
                ),
              ),
            ],
          ),
          Gap(20),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  keyboardType: TextInputType.number,
                  title: "Tinggi Badan",
                  hint: "000",
                  endIcon: Text(
                    "cm",
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: AppColors.textGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Gap(20),
              Expanded(
                child: AppTextField(
                  keyboardType: TextInputType.number,
                  title: "Berat Badan",
                  hint: "000",
                  endIcon: Text(
                    "kg",
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: AppColors.textGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
            onTap: () => _selectDate(),
          ),
          Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Berapa lingkar pinggang kamu?",
                style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600, color: AppColors.textBlack),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.question_mark,
                  size: 16,
                  color: AppColors.secondary,
                ),
              )
            ],
          ),
          Gap(8),
          Wrap(
            spacing: 8.0, // Space between chips
            children: options.map((option) {
              return ChoiceChip(
                label: Text(option),
                selected: selectedOption == option,
                onSelected: (bool selected) {
                  setState(() {
                    selectedOption = selected ? option : '';
                  });
                },
              );
            }).toList(),
          ),
          AppButton(
            caption: "SELANJUTNYA",
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? _pickedDate = await showDatePicker(
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
    if (_pickedDate != null) {
      setState(() {
        log(_pickedDate.toString());
      });
    }
  }
}
