import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_button.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/core/widgets/app_theme.dart';
import 'package:nutrisee/gen/assets.gen.dart';
import 'package:nutrisee/ui/profile/widget/gauge_bmi.dart';
import 'package:nutrisee/ui/profile/widget/item_profile.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
        child: CustomScrollView(
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
                            "Pria",
                            style: context.textTheme.bodyLarge?.copyWith(
                              color: AppColors.textGray,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Haidar Alfathin",
                            style: context.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Gap(12),
                          Container(
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
                              "Penderita Diabetes (Tipe 2)",
                              style: context.textTheme.titleSmall?.copyWith(
                                color: Colors.orange.shade900,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Assets.images.imgArticle.provider(),
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
                  Gap(20),
                  Container(
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
                                    text: "OVERWEIGHT",
                                    style:
                                        context.textTheme.titleLarge?.copyWith(
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
                        const GaugeBmi(
                          bmiValue: 24.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            itemData(
                              context,
                              "Umur",
                              "50",
                            ),
                            itemData(
                              context,
                              "Berat",
                              "75",
                            ),
                            itemData(
                              context,
                              "Tinggi",
                              "175",
                            ),
                          ],
                        ),
                        const Gap(12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            itemKalori(context, "1923", "BMR"),
                            const Gap(14),
                            itemKalori(context, "2034", "Kalori/hari"),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Gap(20),
                  itemSetting(
                    context,
                    title: "Edit Profile",
                  ),
                  Gap(14),
                  itemSetting(
                    context,
                    title: "Tentang Aplikasi",
                  ),
                  Gap(20),
                  AppButton(
                    onPressed: () {},
                    caption: "Logout",
                    useIcon: false,
                    color: Colors.red.shade400,
                  ),
                  Gap(20),
                ],
              ),
            )
          ],
        ),
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
      crossAxisAlignment: CrossAxisAlignment.start,
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
