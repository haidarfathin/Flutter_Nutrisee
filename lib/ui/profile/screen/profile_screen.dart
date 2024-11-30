import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_alert_dialog.dart';
import 'package:nutrisee/core/widgets/app_button.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/core/widgets/app_snackbar.dart';
import 'package:nutrisee/core/widgets/app_theme.dart';
import 'package:nutrisee/gen/assets.gen.dart';
import 'package:nutrisee/ui/auth/bloc/auth_cubit.dart';
import 'package:nutrisee/ui/profile/cubit/profile_cubit.dart';
import 'package:nutrisee/ui/profile/widget/gauge_bmi.dart';
import 'package:nutrisee/ui/scan_product/utils/nutrition_utils.dart';
// import 'package:syncfusion_flutter_gauges/gauges.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final cubit = ProfileCubit();

  @override
  void initState() {
    super.initState();
    cubit.fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBG,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(
          'Profile',
        ),
      ),
      body: BlocProvider.value(
        value: cubit,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.marginHorizontal,
          ),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is GetProfileLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.amber,
                  ),
                );
              } else if (state is GetProfileError) {
                log(state.message.toString());
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is GetProfileSuccess) {
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.data.gender.toUpperCase(),
                                    style:
                                        context.textTheme.bodyLarge?.copyWith(
                                      color: AppColors.textGray,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${state.data.firstName} ${state.data.lastName}",
                                    style:
                                        context.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const Gap(12),
                                  Row(
                                    children: [
                                      if (state.data.hasHipertensi)
                                        SizedBox(
                                          width: 170,
                                          child: medicalCard(
                                            context,
                                            text: "Hipertensi",
                                            backgroundColor:
                                                Colors.red.shade900,
                                            foregroundColor: Colors.white,
                                          ),
                                        )
                                      else if (state.data.hasDiabetes)
                                        SizedBox(
                                          width: 170,
                                          child: medicalCard(
                                            context,
                                            text:
                                                "Diabetes (Tipe ${state.data.diabetesType})",
                                            backgroundColor:
                                                state.data.diabetesType == '1'
                                                    ? Colors.yellow.shade700
                                                    : Colors.orange.shade800,
                                            foregroundColor: Colors.white,
                                          ),
                                        )
                                      else
                                        SizedBox(
                                          width: 170,
                                          child: medicalCard(
                                            context,
                                            text: "Tidak ada riwayat",
                                            backgroundColor: Colors.black,
                                            foregroundColor: Colors.white,
                                          ),
                                        ),
                                      BlocListener<ProfileCubit, ProfileState>(
                                        listener: (context, state) {
                                          if (state is ChangeSickSuccess) {
                                            context.showSnackbar(
                                              "Berhasil mengubah data",
                                              isPositive: true,
                                            );
                                            cubit
                                                .fetchProfile(); // Refresh profile
                                            Navigator.of(context)
                                                .pop(); // Tutup dialog
                                          } else if (state is ChangeSickError) {
                                            context.showSnackbar(
                                              state.message ??
                                                  "Gagal mengupdate, Mohon Coba lagi",
                                            );
                                            Navigator.of(context)
                                                .pop(); // Tutup dialog
                                          } else if (state
                                              is ChangeSickLoading) {
                                            // Tampilkan loading dialog
                                            context.pushReplacement('/profile');
                                          }
                                        },
                                        child: IconButton(
                                          icon: Text(
                                            "Ubah",
                                            style: context.textTheme.bodySmall
                                                ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                          onPressed: () {
                                            context.showCustomDialog(
                                              content: Container(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                height: 310,
                                                width: 200,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Edit Riwayat Penyakit",
                                                      style: context
                                                          .textTheme.bodyLarge
                                                          ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const Gap(14),
                                                    InkWell(
                                                      splashColor: Colors.amber,
                                                      onTap: () {
                                                        context
                                                            .read<
                                                                ProfileCubit>()
                                                            .changeMedicalIssue(
                                                                '2');
                                                      },
                                                      child: SizedBox(
                                                        height: 50,
                                                        child: medicalCard(
                                                          context,
                                                          text:
                                                              "Diabetes (Tipe 1)",
                                                          backgroundColor:
                                                              Colors.yellow
                                                                  .shade700,
                                                          foregroundColor:
                                                              Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    const Gap(10),
                                                    InkWell(
                                                      splashColor: Colors
                                                          .orange.shade200,
                                                      onTap: () {
                                                        context
                                                            .read<
                                                                ProfileCubit>()
                                                            .changeMedicalIssue(
                                                                '3');
                                                      },
                                                      child: SizedBox(
                                                        height: 50,
                                                        child: medicalCard(
                                                          context,
                                                          text:
                                                              "Diabetes (Tipe 2)",
                                                          backgroundColor:
                                                              Colors.orange
                                                                  .shade800,
                                                          foregroundColor:
                                                              Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    const Gap(10),
                                                    InkWell(
                                                      splashColor:
                                                          Colors.red.shade300,
                                                      onTap: () {
                                                        context
                                                            .read<
                                                                ProfileCubit>()
                                                            .changeMedicalIssue(
                                                                '1');
                                                      },
                                                      child: SizedBox(
                                                        height: 50,
                                                        child: medicalCard(
                                                          context,
                                                          text: "Hipertensi",
                                                          backgroundColor:
                                                              Colors
                                                                  .red.shade800,
                                                          foregroundColor:
                                                              Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    const Gap(10),
                                                    InkWell(
                                                      splashColor:
                                                          Colors.red.shade300,
                                                      onTap: () {
                                                        context
                                                            .read<
                                                                ProfileCubit>()
                                                            .changeMedicalIssue(
                                                                '4');
                                                      },
                                                      child: SizedBox(
                                                        height: 50,
                                                        child: medicalCard(
                                                          context,
                                                          text: "Hapus Riwayat",
                                                          backgroundColor:
                                                              Colors.grey
                                                                  .shade200,
                                                          foregroundColor:
                                                              Colors.black87,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          color: Colors.orange,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                height: 125,
                                width: 125,
                                margin: const EdgeInsets.only(
                                  top: 10,
                                ),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade100,
                                  shape: BoxShape.circle,
                                  border: const GradientBoxBorder(
                                    width: 10,
                                    gradient: AppColors.greenGradient,
                                  ),
                                ),
                                child:
                                    (state.data.gender.toLowerCase() == "pria")
                                        ? Assets.images.icMale.image()
                                        : Assets.images.icFemale.image(),
                              ),
                            ],
                          ),
                          const Gap(20),
                          cardProfile(
                            context,
                            height: state.data.height,
                            weight: state.data.weight,
                            birthDate: state.data.birthDate,
                            gender: state.data.gender,
                            bmr: state.data.bmr ?? 0,
                            tdee: state.data.tdee ?? 0,
                          ),
                          const Gap(20),
                          itemSetting(
                            context,
                            title: "Edit Profile",
                          ),
                          const Gap(14),
                          itemSetting(
                            context,
                            title: "Tentang Aplikasi",
                          ),
                          const Gap(20),
                          BlocProvider(
                            create: (context) => AuthCubit(),
                            child: BlocConsumer<AuthCubit, AuthState>(
                              listener: (context, state) {
                                if (state is AuthSuccess) {
                                  context.go('/');
                                } else if (state is AuthError) {
                                  context.showSnackbar(state.message ?? "");
                                }
                              },
                              builder: (context, state) {
                                return AppButton(
                                  caption: "Logout",
                                  onPressed: () {
                                    context.read<AuthCubit>().logout();
                                  },
                                  useIcon: false,
                                  color: Colors.red.shade400,
                                );
                              },
                            ),
                          ),
                          const Gap(20),
                        ],
                      ),
                    )
                  ],
                );
              } else {
                log("MASHIK");
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget medicalCard(
    BuildContext context, {
    required String text,
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 12,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: backgroundColor ?? Colors.grey.shade300),
      child: Text(
        text,
        style: context.textTheme.titleSmall?.copyWith(
          color: foregroundColor?.withOpacity(0.8) ??
              Colors.black.withOpacity(0.8),
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Container cardProfile(
    BuildContext context, {
    required DateTime birthDate,
    required String gender,
    required int height,
    required double bmr,
    required double tdee,
    weight,
  }) {
    var bmiResult = calculateBMI(height, weight);
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
                      text: examineBMI(height, weight),
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
          GaugeBmi(
            bmiValue: bmiResult,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              itemData(
                context,
                "Umur",
                calculateAge(birthDate).toString(),
              ),
              itemData(
                context,
                "Berat",
                weight.toString(),
              ),
              itemData(
                context,
                "Tinggi",
                height.toString(),
              ),
              itemData(
                context,
                "BMI",
                bmiResult.toString(),
              ),
            ],
          ),
          const Gap(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              itemKalori(
                  context,
                  // calculateBMR(
                  //   gender,
                  //   height.toDouble(),
                  //   weight.toDouble(),
                  //   calculateAge(birthDate),
                  // ).toString(),
                  bmr.toInt().toString(),
                  "BMR"),
              const Gap(14),
              itemKalori(context, tdee.toInt().toString(), "Kalori/hari"),
            ],
          )
        ],
      ),
    );
  }

  InkWell itemSetting(
    BuildContext context, {
    Function()? onTap,
    required String title,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: AppColors.grayBG,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textGray,
              ),
            ),
            const Icon(
              Ionicons.chevron_forward,
              color: AppColors.textGray,
            )
          ],
        ),
      ),
    );
  }

  Expanded itemKalori(
    BuildContext context,
    String data,
    String subtitle,
  ) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.green.shade200,
        ),
        child: Column(
          children: [
            Text(
              data,
              style: context.textTheme.bodyLarge?.copyWith(
                color: Colors.green.shade900,
                fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
            ),
            Text(
              subtitle,
              style: context.textTheme.bodyLarge?.copyWith(
                color: Colors.black45,
                fontWeight: FontWeight.w600,
                fontSize: 10,
              ),
            )
          ],
        ),
      ),
    );
  }

  Column itemData(
    BuildContext context,
    String title,
    String data,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
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

int calculateBMR(
  String gender,
  double height,
  double weight,
  int age,
) {
  double bmr;
  if (gender == "pria") {
    bmr = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
  } else {
    bmr = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
  }

  return bmr.toInt();
}

String examineBMI(int height, int weight) {
  var bmi = calculateBMI(height, weight);
  if (bmi < 18.5) {
    return "UNDERWEIGHT";
  } else if (bmi >= 18.5 && bmi < 24.9) {
    return "IDEAL";
  } else if (bmi >= 25 && bmi < 29.9) {
    return "OVERWEIGHT";
  } else {
    return "OBESE";
  }
}

double calculateBMI(int height, int weight) {
  var heightMeter = height / 100;
  var heightKuadrat = heightMeter * heightMeter;
  var bmi = weight / heightKuadrat;
  return bmi = roundDouble(bmi, 1);
}
