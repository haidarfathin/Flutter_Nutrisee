import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/core/widgets/app_textfield.dart';
import 'package:nutrisee/core/widgets/app_theme.dart';
import 'package:nutrisee/gen/assets.gen.dart';
import 'package:nutrisee/ui/scan_product/widget/nutrition_container.dart';
import 'package:nutrisee/ui/scan_product/widget/tips_card.dart';

class DetailResultScreen extends StatefulWidget {
  const DetailResultScreen({super.key});

  @override
  State<DetailResultScreen> createState() => _DetailResultScreenState();
}

class _DetailResultScreenState extends State<DetailResultScreen> {
  bool isEdit = false;
  TextEditingController nameController =
      TextEditingController(text: "Produk #1");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBG,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text("Detail Produk"),
            centerTitle: true,
            scrolledUnderElevation: 0,
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Assets.images.imgArticle.image(
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.marginHorizontal,
                vertical: AppTheme.marginVertical,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        child: TextField(
                          controller: nameController,
                          enabled: isEdit,
                          style: context.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isEdit ? Colors.black : Colors.grey,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.start,
                          cursorColor: AppColors.secondary,
                          decoration: InputDecoration(
                            border: isEdit ? null : InputBorder.none,
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.primary,
                                width: 2,
                              ),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Gap(10),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isEdit = !isEdit;
                          });
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isEdit
                                ? AppColors.orangeSwatch.shade100
                                : AppColors.ancientSwatch.shade100,
                          ),
                          child: isEdit
                              ? Icon(
                                  Icons.save_rounded,
                                  size: 20,
                                  color: AppColors.orangeSwatch.shade400,
                                )
                              : const Icon(
                                  Icons.edit_square,
                                  size: 20,
                                  color: AppColors.primary,
                                ),
                        ),
                      )
                    ],
                  ),
                  const Gap(12),
                  Text(
                    "Nutriscore",
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      Assets.images.icScoreA.image(height: 60),
                      const Gap(12),
                      Expanded(
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.orangeSwatch.shade100,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.info_rounded,
                                color: AppColors.orangeSwatch.shade400,
                              ),
                              const Gap(8),
                              Text(
                                "Kandungan Gula Tinggi",
                                style: context.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.orangeSwatch.shade400,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      NutritionContainer(
                        kandungan: 30,
                        background: AppColors.orangeSwatch,
                        title: "Gula",
                      ),
                      NutritionContainer(
                        kandungan: 70,
                        background: AppColors.orangeSwatch.shade300,
                        title: "Lemak Jenuh",
                      ),
                      NutritionContainer(
                        kandungan: 2000,
                        background: AppColors.orangeSwatch.shade200,
                        title: "Garam",
                      ),
                    ],
                  ),
                  const Gap(20),
                  Text(
                    "Saran dari NutriseeAI",
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(8),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Text(
                      "30 gram gula setara dengan 2 sendok makan. "
                      "Mengonsumsi 30 gram gula sudah mencapai 50-55% "
                      "dari batas asupan gula harian yang direkomendasikan "
                      "oleh Kementrian Keseharan Republik Indonesia (50 gram untuk "
                      "wanita, 65 gram untuk pria). Mengonsumsi gula berlebihan dapat "
                      "meningkatkan risiko terkena diabetes.",
                      style: context.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w500, fontSize: 11),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const Gap(20),
                  Text(
                    "Tips",
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(8),
                  const TipsCard(
                    imagePath: "assets/images/ic_running.png",
                    text:
                        "Dianjurkan untuk berolahraga minimal 30 menit setiap hari, seperti berjalan kaki, bersepeda, atau berenang.",
                  ),
                  const Gap(10),
                  const TipsCard(
                    imagePath: "assets/images/ic_veggies.png",
                    text:
                        "Konsumsi makanan kaya serat seperti sayur, buah, dan kacang-kacangan untuk membantu mengontrol kadar gula darah.",
                  ),
                  const Gap(10),
                  const TipsCard(
                    imagePath: "assets/images/ic_sleep.png",
                    text:
                        "Tidur yang cukup untuk membantu tubuh mengatur kadar gula darah.",
                  ),
                  const Gap(10),
                  const TipsCard(
                    imagePath: "assets/images/ic_water.png",
                    text:
                        "Minum air putih yang cukup untuk membantu tubuh mengeluarkan gula berlebih.",
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
