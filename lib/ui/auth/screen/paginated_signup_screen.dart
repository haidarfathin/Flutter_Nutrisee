import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:intl/intl.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_button.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
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

  String? _selectedGender;
  bool? _isDiabetisi;
  String? _diabetesType;
  int currentStep = 0;
  DateTime? birthDate;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        if (currentStep == 0) {
          context.pop();
        } else {
          currentStep--;
        }
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
                                } else if (currentStep == 2 &&
                                    _isDiabetisi == true) {
                                  if (_isDiabetisi == null) {
                                    context.showSnackbar("Are you diabetes?");
                                  } else {
                                    setState(() {
                                      currentStep++;
                                    });
                                  }
                                } else if (currentStep == 2 &&
                                    _isDiabetisi == false) {
                                  if (_isDiabetisi == null) {
                                    context.showSnackbar("Are you diabetes?");
                                  } else {
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
                                      hasDiabetes: _isDiabetisi!,
                                    );
                                  }
                                } else if (currentStep == 3) {
                                  if (_diabetesType == "") {
                                    context.showSnackbar(
                                        "Please Fill Your Diabetes Type");
                                  } else {
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
                                      hasDiabetes: _isDiabetisi!,
                                      diabetesType: _diabetesType!,
                                    );
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
                        Gap(20),
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
          Column(
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
                      isSelected: _isDiabetisi == true,
                      onTap: () => setState(() => _isDiabetisi = true),
                    ),
                  ),
                  const Gap(20),
                  Expanded(
                    child: DiabetisiRadio(
                      image: Assets.images.icDiabetisiNo.image(),
                      title: "Non-Diabetisi",
                      isSelected: _isDiabetisi == false,
                      onTap: () => setState(() => _isDiabetisi = false),
                    ),
                  ),
                ],
              ),
              const Gap(30),
              Text(
                "Dengan mengetahui status kesehatan anda,\nNutrisee dapat membantu anda\ndengan lebih baik\n",
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
      context: context,
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
}
