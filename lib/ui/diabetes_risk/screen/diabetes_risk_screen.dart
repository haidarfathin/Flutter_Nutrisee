import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_button.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/core/widgets/app_theme.dart';
import 'package:nutrisee/gen/assets.gen.dart';

class DiabetesRiskScreen extends StatelessWidget {
  const DiabetesRiskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBG,
      appBar: AppBar(
        title: Text("Risiko Diabetes"),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.marginHorizontal,
          vertical: AppTheme.marginVertical,
        ),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Assets.images.icDiabetesTest.image(width: 200),
                  Gap(10),
                  Text(
                    "Cek Risiko Diabetes Anda",
                    style: context.textTheme.titleLarge,
                  ),
                  Gap(8),
                  Text(
                    "Tingkatkan kesadaran anda terhadap Diabetes: "
                    "cek risiko anda sekarang dan ambil langkah awal "
                    "untuk gaya hidup lebih sehat dan bebas diabetes",
                    style: context.textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: AppColors.orangeGradient,
                  ),
                  child: Row(
                    children: [
                      Assets.images.icWarning.image(width: 46),
                      Gap(12),
                      Expanded(
                        child: Text(
                          "Hasil tes ini tidak menggantikan peran "
                          "dokter dalam mengidentifikasi risiko diabetes anda, "
                          "silahkan hubungi dokter untuk penanganan lebih lanjut "
                          "dan hasil yang akurat.",
                          style: context.textTheme.bodySmall?.copyWith(
                            color: AppColors.black,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(20),
                AppButton(
                  onPressed: () {
                    context.push("/diabetes-risk-steps");
                  },
                  caption: "Mulai Tes",
                  useIcon: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
