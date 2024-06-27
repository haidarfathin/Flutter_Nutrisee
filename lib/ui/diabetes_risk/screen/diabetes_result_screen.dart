import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_button.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/core/widgets/app_theme.dart';
import 'package:nutrisee/gen/assets.gen.dart';
import 'package:nutrisee/ui/diabetes_risk/widget/linear_range.dart';

class DiabetesResultScreen extends StatelessWidget {
  final Map<String, dynamic> diabetesResult;
  const DiabetesResultScreen({super.key, required this.diabetesResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBG,
      appBar: AppBar(
        title: const Text("Hasil Risiko Diabetes"),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.marginHorizontal,
            vertical: AppTheme.marginVertical,
          ),
          child: Column(
            children: [
              Assets.images.icDiabetesTest.image(width: 250),
              const Gap(20),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.ancientSwatch.shade50,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 4),
                          ),
                        ]),
                    child: Column(
                      children: [
                        Text(
                          "Level Risiko Anda adalah",
                          style: context.textTheme.bodyLarge?.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.ancientSwatch.shade400,
                          ),
                        ),
                        const Gap(8),
                        Text(
                          interpretRiskScore(diabetesResult['score']),
                          style: context.textTheme.headlineLarge
                              ?.copyWith(color: AppColors.textBlack),
                        ),
                        const Gap(14),
                        LinearRange(
                          sections: [
                            RangeSection(color: Colors.green, flex: 2),
                            RangeSection(color: Colors.lightGreen, flex: 3),
                            RangeSection(color: Colors.yellow, flex: 2),
                            RangeSection(color: Colors.orange, flex: 4),
                            RangeSection(color: Colors.red, flex: 3),
                          ],
                          markerPosition: diabetesResult['score'],
                        ),
                        const Gap(16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: diabetesResult['score'].toString(),
                                style: context.textTheme.headlineLarge,
                                children: [
                                  TextSpan(
                                    text: " poin",
                                    style: context.textTheme.bodyLarge,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: 3,
                              height: 30,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              color: AppColors.ancient,
                            ),
                            RichText(
                              text: TextSpan(
                                text: diabetesResult['percent'],
                                style: context.textTheme.headlineLarge,
                                children: [
                                  TextSpan(
                                    text: " risiko 10 tahun kedepan",
                                    style: context.textTheme.bodyLarge,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Gap(10),
                        const Divider(color: AppColors.primary),
                        const Gap(10),
                        Text(
                          "Hasil dapat bervariasi sesuai data yang dimasukkan, tetap pertimbangkan pemeriksaan formal dengan HgbA1c untuk pasien dengan risiko sedang atau lebih tinggi. Faktor risiko dapat berubah-ubah, tetap jaga kesehatan dengan meningkatkan aktifitas fisik dan menjaga pola makan sehat.",
                          style: context.textTheme.bodyLarge,
                          textAlign: TextAlign.justify,
                        )
                      ],
                    ),
                  ),
                  const Gap(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Artikel Terbaru",
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(8),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 250,
                              margin: const EdgeInsets.only(right: 14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 75,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16),
                                      ),
                                      color: Colors.green,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 16,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Sayuran Yang Cocok Untuk Pengidap Diabetes",
                                          style: context.textTheme.bodyLarge
                                              ?.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        const Gap(8),
                                        Text(
                                          "Kamu harus cermat saat memilih "
                                          "sayur dan buah untuk penderita diabetes. "
                                          "Soalnya, tidak semua jenis buah aman buat "
                                          "penderita diabetes,",
                                          style: context.textTheme.bodySmall
                                              ?.copyWith(fontSize: 10),
                                          textAlign: TextAlign.justify,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                  AppButton(
                    onPressed: () {
                      context.go("/menu");
                    },
                    caption: "Kembali ke Beranda",
                    useIcon: false,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String interpretRiskScore(int score) {
    if (score <= 8) {
      return "Resiko rendah";
    } else if (score >= 9 && score <= 12) {
      return "Resiko Sedang";
    } else if (score >= 13 && score <= 20) {
      return "Resiko Tinggi";
    } else if (score >= 21) {
      return "Resiko Sangat Tinggi";
    } else {
      return "Invalid";
    }
  }
}
