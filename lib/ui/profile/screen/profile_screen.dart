import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nutrisee/core/utils/session.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_button.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/core/widgets/app_snackbar.dart';
import 'package:nutrisee/core/widgets/app_theme.dart';
import 'package:nutrisee/gen/assets.gen.dart';
import 'package:nutrisee/ui/auth/bloc/auth_cubit.dart';
import 'package:nutrisee/ui/profile/cubit/profile_cubit.dart';
import 'package:nutrisee/ui/profile/widget/gauge_bmi.dart';
import 'package:nutrisee/ui/profile/widget/item_profile.dart';
import 'package:nutrisee/ui/scan_product/screen/detail_result_screen.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.marginHorizontal,
        ),
        child: BlocProvider(
          create: (context) => ProfileCubit()..fetchProfile(),
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
                                  state.data.hasDiabetes == false
                                      ? Container()
                                      : diabetesCard(
                                          context,
                                          diabetesType:
                                              state.data.diabetesType ?? "",
                                        )
                                ],
                              ),
                              Container(
                                height: 125,
                                width: 125,
                                margin: const EdgeInsets.only(
                                  top: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade100,
                                  image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      "assets/images/ic_male_circle.png",
                                    ),
                                  ),
                                  shape: BoxShape.circle,
                                  border: const GradientBoxBorder(
                                    width: 5,
                                    gradient: AppColors.greenGradient,
                                  ),
                                ),
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
                            calories: state.data.calories ?? 0,
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
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget diabetesCard(
    BuildContext context, {
    required String diabetesType,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.orange.shade200,
      ),
      child: Text(
        "Penderita Diabetes (Tipe $diabetesType)",
        style: context.textTheme.titleSmall?.copyWith(
          color: Colors.orange.shade900,
          fontSize: 10,
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
    required int calories,
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
                  calculateBMR(
                    gender,
                    height.toDouble(),
                    weight.toDouble(),
                    calculateAge(birthDate),
                  ).toString(),
                  "BMR"),
              const Gap(14),
              itemKalori(context, calories.toString(), "Kalori/hari"),
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
