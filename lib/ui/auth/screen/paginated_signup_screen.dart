import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_button.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/core/widgets/app_textfield.dart';
import 'package:nutrisee/core/widgets/app_theme.dart';
import 'package:nutrisee/gen/assets.gen.dart';
import 'package:nutrisee/core/widgets/app_radio.dart';
import 'package:nutrisee/ui/auth/widget/diabetes_type_radio.dart';

import '../widget/diebetisi_radio.dart';

class PaginatedSignupScreen extends StatefulWidget {
  const PaginatedSignupScreen({super.key});

  @override
  State<PaginatedSignupScreen> createState() => _PaginatedSignupScreenState();
}

class _PaginatedSignupScreenState extends State<PaginatedSignupScreen> {
  String? _selectedGender = 'l';
  String? _isDiabetisi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBG,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.marginHorizontal,
            vertical: AppTheme.marginVertical,
          ),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Langkah 2 dari 3",
                style: context.textTheme.bodyLarge,
              ),
              const Gap(12),
              Text(
                "Apa tipe Diabetes anda?",
                style: context.textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const Gap(30),
              Column(
                children: [
                  DiabetesTypeRadio(
                    title: "Tipe 1",
                    subtitle:
                        "Kondisi dimana tubuh tidak dapat menghasilkan insulin",
                    isSelected: _isDiabetisi == "y",
                    onTap: () => setState(() => _isDiabetisi = "y"),
                  ),
                  Gap(20),
                  DiabetesTypeRadio(
                    title: "Tipe 2",
                    subtitle:
                        "Kondisi dimana insulin dalam tubuh tidak dapat bekerja dengan efektif atau tidak cukup",
                    isSelected: _isDiabetisi == "n",
                    onTap: () => setState(() => _isDiabetisi = "n"),
                  ),
                ],
              ),
              const Gap(50),
              AppButton(
                caption: "DAFTAR",
                useIcon: false,
                onPressed: () {
                  context.go('/home');
                },
              ),
            ],
          )),
        ),
      ),
    );
  }

  Column stepTwo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Langkah 2 dari 3",
          style: context.textTheme.bodyLarge,
        ),
        const Gap(12),
        Text(
          "Apakah anda Diabetisi?*",
          style: context.textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
        const Gap(8),
        Text(
          '*penderita diabetes',
          style: context.textTheme.bodySmall,
        ),
        const Gap(30),
        Row(
          children: [
            Expanded(
              child: DiabetisiRadio(
                image: Assets.images.icDiabetisiYes.image(),
                title: "Diabetisi",
                isSelected: _isDiabetisi == "y",
                onTap: () => setState(() => _isDiabetisi = "y"),
              ),
            ),
            Gap(20),
            Expanded(
              child: DiabetisiRadio(
                image: Assets.images.icDiabetisiNo.image(),
                title: "Non-Diabetisi",
                isSelected: _isDiabetisi == "n",
                onTap: () => setState(() => _isDiabetisi = "n"),
              ),
            ),
          ],
        ),
        Gap(30),
        Text(
          "Dengan mengetahui status kesehatan anda,\nNutrisee dapat membantu anda\ndengan lebih baik\n",
          style: context.textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
        const Gap(50),
        AppButton(
          caption: "SELANJUTNYA",
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PaginatedSignupScreen(),
                ));
          },
        ),
      ],
    );
  }

  Column stepOne(BuildContext context) {
    return Column(
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
        const Gap(50),
        AppButton(
          caption: "SELANJUTNYA",
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PaginatedSignupScreen(),
                ));
          },
        ),
        const Gap(30),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Sudah punya akun? ",
                style: context.textTheme.bodyLarge,
              ),
              TextSpan(
                text: "Masuk",
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              )
            ],
          ),
        ),
      ],
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
