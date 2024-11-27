import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:intl/intl.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_button.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/core/widgets/app_dropdown.dart';
import 'package:nutrisee/core/widgets/app_snackbar.dart';
import 'package:nutrisee/core/widgets/app_textfield.dart';
import 'package:nutrisee/core/widgets/app_theme.dart';
import 'package:nutrisee/gen/assets.gen.dart';
import 'package:nutrisee/core/widgets/app_radio.dart';
import 'package:nutrisee/ui/auth/bloc/auth_cubit.dart';
import 'package:nutrisee/ui/auth/widget/diabetes_type_radio.dart';

import '../widget/diebetisi_radio.dart';

class PaginatedSignupScreen extends StatefulWidget {
  const PaginatedSignupScreen({super.key});

  @override
  State<PaginatedSignupScreen> createState() => _PaginatedSignupScreenState();
}

class _PaginatedSignupScreenState extends State<PaginatedSignupScreen> {
  AuthCubit cubit = AuthCubit();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  final TextEditingController rePwdController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController sysController = TextEditingController();
  final TextEditingController diaController = TextEditingController();
  final TextEditingController pulseController = TextEditingController();

  String? _selectedGender;
  bool medicalIssue = false;
  bool isDiabetisi = false;
  bool isHipertensi = false;
  String? _diabetesType;
  int currentStep = 0;
  DateTime? birthDate;
  String? levelAktifitas;
  bool hasTensi = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        setState(() {
          currentStep--;
        });
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteBG,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          scrolledUnderElevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.marginHorizontal,
          ),
          child: CustomScrollView(
            slivers: [
              stepper(context),
              BlocProvider(
                create: (context) => cubit,
                child: BlocListener<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is RegisterSuccess) {
                      setState(() {
                        currentStep++;
                      });
                    } else if (state is AuthError) {
                      context.showSnackbar(state.message ?? "");
                    } else if (state is SaveDataSuccess) {
                      context.go("/menu");
                    }
                  },
                  child: SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Gap(20),
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            return AppButton(
                              caption:
                                  currentStep == 0 ? "Daftar" : "Selanjutnya",
                              onPressed: () {
                                if (currentStep == 0) {
                                  if (mailController.text.isEmpty) {
                                    context.showSnackbar("Fill Your Email");
                                  } else if (pwdController.text.isEmpty ||
                                      rePwdController.text.isEmpty) {
                                    context.showSnackbar("Fill Your Password");
                                  } else if (pwdController.text !=
                                      rePwdController.text) {
                                    context
                                        .showSnackbar("Password doesn't match");
                                  } else {
                                    cubit.signup(
                                      mailController.text,
                                      pwdController.text,
                                    );
                                  }
                                } else if (currentStep == 2) {
                                  if (isDiabetisi == false &&
                                      isHipertensi == false &&
                                      medicalIssue == false) {
                                    context.showSnackbar(
                                        "Pilih pilihan yang sesuai");
                                  } else if (isDiabetisi == true ||
                                      isHipertensi == true) {
                                    setState(() {
                                      currentStep++;
                                    });
                                  } else if (medicalIssue == true) {
                                    cubit.saveUserData(
                                      email: mailController.text,
                                      firstName: firstNameController.text,
                                      lastName: lastNameController.text,
                                      gender: _selectedGender!,
                                      height:
                                          int.tryParse(heightController.text) ??
                                              0,
                                      weight:
                                          int.tryParse(weightController.text) ??
                                              0,
                                      birthDate: birthDate!,
                                      bmr: calculateBMR(
                                        _selectedGender!,
                                        double.parse(heightController.text),
                                        double.parse(weightController.text),
                                        calculateAge(birthDate!),
                                      ),
                                      tdee: calculateTDEE(
                                        _selectedGender!,
                                        double.parse(heightController.text),
                                        double.parse(weightController.text),
                                        calculateAge(birthDate!),
                                        levelAktifitas ?? "1",
                                      ),
                                      hasDiabetes: false,
                                      hasHipertensi: false,
                                    );
                                  }
                                } else if (currentStep == 3) {
                                  {
                                    if (isDiabetisi) {
                                      cubit.saveUserData(
                                        email: mailController.text,
                                        firstName: firstNameController.text,
                                        lastName: lastNameController.text,
                                        gender: _selectedGender!,
                                        height: int.tryParse(
                                                heightController.text) ??
                                            0,
                                        weight: int.tryParse(
                                                weightController.text) ??
                                            0,
                                        birthDate: birthDate!,
                                        hasDiabetes: true,
                                        hasHipertensi: false,
                                        diabetesType: _diabetesType!,
                                        bmr: calculateBMR(
                                          _selectedGender!,
                                          double.parse(heightController.text),
                                          double.parse(weightController.text),
                                          calculateAge(birthDate!),
                                        ),
                                        tdee: calculateTDEE(
                                          _selectedGender!,
                                          double.parse(heightController.text),
                                          double.parse(weightController.text),
                                          calculateAge(birthDate!),
                                          levelAktifitas ?? "1",
                                        ),
                                      );
                                    } else if (isHipertensi) {
                                      cubit.saveUserData(
                                        email: mailController.text,
                                        firstName: firstNameController.text,
                                        lastName: lastNameController.text,
                                        gender: _selectedGender!,
                                        height: int.tryParse(
                                                heightController.text) ??
                                            0,
                                        weight: int.tryParse(
                                                weightController.text) ??
                                            0,
                                        birthDate: birthDate!,
                                        hasDiabetes: false,
                                        hasHipertensi: true,
                                        dataTensi: (hasTensi == false)
                                            ? {
                                                'sys': int.tryParse(
                                                        sysController.text) ??
                                                    0,
                                                'dia': int.tryParse(
                                                        diaController.text) ??
                                                    0,
                                                'pulse': int.tryParse(
                                                        pulseController.text) ??
                                                    0,
                                              }
                                            : {},
                                        bmr: calculateBMR(
                                          _selectedGender!,
                                          double.parse(heightController.text),
                                          double.parse(weightController.text),
                                          calculateAge(birthDate!),
                                        ),
                                        tdee: calculateTDEE(
                                          _selectedGender!,
                                          double.parse(heightController.text),
                                          double.parse(weightController.text),
                                          calculateAge(birthDate!),
                                          levelAktifitas ?? "1",
                                        ),
                                      );
                                    }
                                  }
                                } else {
                                  if (_selectedGender == "") {
                                    context.showSnackbar(
                                        "Please Choose Your Gender");
                                  } else if (heightController.text.isEmpty ||
                                      weightController.text.isEmpty) {
                                    context.showSnackbar(
                                        "Please Fill Your Height and Weight");
                                  } else if (birthDate == null) {
                                    context.showSnackbar(
                                        "Please Input Your Birth Date");
                                  } else {
                                    setState(() {
                                      currentStep++;
                                    });
                                  }
                                }
                              },
                            );
                          },
                        ),
                        currentStep == 0 ? alreadyHadAccount() : Container(),
                        const Gap(20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget alreadyHadAccount() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: RichText(
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
              recognizer: TapGestureRecognizer()
                ..onTap = () => context.push('/login'),
            )
          ],
        ),
      ),
    );
  }

  Widget stepZero(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Assets.images.icLogo.image(height: 15),
              const Gap(24),
              Text(
                "DAFTAR",
                style: context.textTheme.displayLarge,
              ),
              const Gap(70),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 30,
                    child: AppTextField(
                      hint: "Nama depan",
                      controller: firstNameController,
                    ),
                  ),
                  const Gap(20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 30,
                    child: AppTextField(
                      hint: "Nama Belakang",
                      controller: lastNameController,
                    ),
                  ),
                ],
              ),
              const Gap(20),
              AppTextField(
                keyboardType: TextInputType.emailAddress,
                hint: "Your Email",
                controller: mailController,
                startIcon: Ionicons.mail_outline,
              ),
              const Gap(20),
              AppTextField(
                hint: "Password",
                controller: pwdController,
                startIcon: Ionicons.lock_closed_outline,
                obscure: true,
                endIcon: Ionicons.eye,
              ),
              const Gap(20),
              AppTextField(
                hint: "Konfirmasi Password",
                controller: rePwdController,
                startIcon: Ionicons.lock_closed_outline,
                obscure: true,
                endIcon: Ionicons.eye,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget stepThree(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          isDiabetisi
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Langkah 3 dari 3",
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
                          isSelected: _diabetesType == "1",
                          onTap: () => setState(() => _diabetesType = "1"),
                        ),
                        const Gap(20),
                        DiabetesTypeRadio(
                          title: "Tipe 2",
                          subtitle:
                              "Kondisi dimana insulin dalam tubuh tidak dapat bekerja dengan efektif atau tidak cukup",
                          isSelected: _diabetesType == "2",
                          onTap: () => setState(() => _diabetesType = "2"),
                        ),
                      ],
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Langkah 3 dari 3",
                      style: context.textTheme.bodyLarge,
                    ),
                    const Gap(12),
                    Text(
                      "Tekanan darah anda",
                      style: context.textTheme.headlineLarge,
                      textAlign: TextAlign.center,
                    ),
                    const Gap(30),
                    Column(
                      children: [
                        AppTextField(
                          title: "SYS",
                          hint: "Ex: 108",
                          endIcon: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              "mmHg",
                              style: GoogleFonts.roboto(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade700),
                            ),
                          ),
                          controller: sysController,
                        ),
                        const Gap(20),
                        AppTextField(
                          title: "DIA",
                          hint: "Ex: 108",
                          endIcon: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              "mmHg",
                              style: GoogleFonts.roboto(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade700),
                            ),
                          ),
                          controller: diaController,
                        ),
                        const Gap(20),
                        AppTextField(
                          title: "Pulse",
                          hint: "Ex: 85",
                          endIcon: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              "/min",
                              style: GoogleFonts.roboto(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade700),
                            ),
                          ),
                          controller: pulseController,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "---- ATAU ----",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              hasTensi = !hasTensi;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.maxFinite,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: hasTensi
                                  ? Colors.green.shade700
                                  : Colors.grey.shade100,
                              border: Border.all(
                                  color: hasTensi
                                      ? Colors.transparent
                                      : Colors.green.shade600,
                                  width: 2),
                            ),
                            child: Text(
                              "Saya belum pernah melakukan tes \ndalam 1 minggu terakhir",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: hasTensi ? Colors.white : Colors.green,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget stepTwo(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Langkah 2 dari 3",
                style: context.textTheme.bodyLarge,
              ),
              const Gap(12),
              Text(
                "Riwayat kesehatan anda",
                style: context.textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const Gap(30),
              Row(
                children: [
                  Expanded(
                    child: DiabetisiRadio(
                      customHeight: 220,
                      image: Assets.images.icDiabetisiYes.image(),
                      title: "Diabetes",
                      isSelected: isDiabetisi == true,
                      onTap: () {
                        setState(() {
                          isDiabetisi = !isDiabetisi;
                          isHipertensi = false;
                          medicalIssue = false;
                        });
                      },
                    ),
                  ),
                  const Gap(20),
                  Expanded(
                    child: DiabetisiRadio(
                      customHeight: 220,
                      image: Assets.images.icHipertensi.image(),
                      title: "Hipertensi",
                      isSelected: isHipertensi == true,
                      onTap: () {
                        log("TAPPED");
                        setState(() {
                          isHipertensi = !isHipertensi;
                          isDiabetisi = false;
                          medicalIssue = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const Gap(20),
              DiabetisiRadio(
                customWidth: double.maxFinite,
                customHeight: 75,
                title: "Tidak memiliki riwayat penyakit diatas",
                isSelected: medicalIssue == true,
                onTap: () {
                  setState(() {
                    medicalIssue = !medicalIssue;
                    if (medicalIssue) {
                      isDiabetisi = false;
                      isHipertensi = false;
                    }
                  });
                },
              ),
              const Gap(30),
              Text(
                "Dengan mengenali riwayat penyakit anda, \nkami dapat menyesuaikan batas konsumsi \ngula dan garam harian anda.",
                style: context.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget stepOne(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Column(
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
              ),
              const Gap(20),
              AppDropdown(
                title: "Level Aktivitas",
                hint: "Pilih Level Aktivitas",
                startIcon: Ionicons.walk,
                textHintColor: Colors.green,
                onSelected: (value) {
                  setState(() {
                    levelAktifitas = value;
                  });
                },
                onChanged: (value) {
                  setState(() {
                    levelAktifitas = value;
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
        ],
      ),
    );
  }

  Widget stepper(BuildContext context) {
    if (currentStep == 0) {
      return stepZero(context);
    } else if (currentStep == 1) {
      return stepOne(context);
    } else if (currentStep == 2) {
      return stepTwo(context);
    } else {
      return stepThree(context);
    }
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
      context: context as BuildContext,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime(3000),
    );
    if (_pickedDate != null) {
      setState(() {
        birthDate = _pickedDate;
        birthDateController.text = DateFormat('dd-MM-yyyy').format(_pickedDate);
      });
    }
  }

  int calculateAge(DateTime birthDate) {
    int age = DateTime.now().year - birthDate.year;
    if (DateTime.now().month < birthDate.month ||
        (DateTime.now().month == birthDate.month &&
            DateTime.now().day < birthDate.day)) {
      age--;
    }
    return age;
  }

  double calculateBMR(
    String gender,
    double height,
    double weight,
    int age,
  ) {
    double bmr;
    if (gender == "pria") {
      bmr = (10 * weight) + (6.25 * height) - (5 * age) + 5;
    } else {
      bmr = (10 * weight) + (6.25 * height) - (5 * age) - 161;
    }

    return bmr;
  }

  double calculateTDEE(
    String gender,
    double height,
    double weight,
    int age,
    String levelAktifitas,
  ) {
    double bmr;
    if (gender == "pria") {
      bmr = (10 * weight) + (6.25 * height) - (5 * age) + 5;
    } else {
      bmr = (10 * weight) + (6.25 * height) - (5 * age) - 161;
    }
    double activityMultiplier;
    switch (levelAktifitas) {
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
    return tdee;
  }
}
