import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/utils/translation.dart';
import 'package:nutrisee/core/widgets/app_alert_dialog.dart';
import 'package:nutrisee/core/widgets/app_button.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/core/widgets/app_snackbar.dart';
import 'package:nutrisee/core/widgets/app_theme.dart';
import 'package:nutrisee/gen/assets.gen.dart';
import 'package:intl/intl.dart';
import 'package:nutrisee/ui/count_calories/cubit/calorie_cubit.dart';

class ResultCaloriesScreen extends StatefulWidget {
  final Map<String, double> dataCalories;
  const ResultCaloriesScreen({super.key, required this.dataCalories});

  @override
  State<ResultCaloriesScreen> createState() => _ResultCaloriesScreenState();
}

class _ResultCaloriesScreenState extends State<ResultCaloriesScreen> {
  @override
  Widget build(BuildContext context) {
    int bmrValue = widget.dataCalories['BMR']!.toInt();
    int tdeeValue = widget.dataCalories['TDEE']!.toInt();
    return Scaffold(
      backgroundColor: AppColors.whiteBG,
      appBar: AppBar(
        title: const Text("Hasil Kalori Harian"),
        scrolledUnderElevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.go('/calories');
            },
            icon: const Icon(
              Icons.refresh,
            ),
          ),
        ],
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
                  Assets.images.icCalories.image(height: 200),
                  const Gap(16),
                  Text(
                    "${NumberFormat('#,###').format(tdeeValue)} KKal",
                    style: GoogleFonts.poppins(
                      fontSize: 30,
                      color: Colors.orange.shade600,
                      fontWeight: FontWeight.w800,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  // const Gap(4),
                  Text(
                    "Kebutuhan kalori harian anda",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                    ),
                  ),
                  const Gap(10),
                  ExpansionTile(
                    initiallyExpanded: true,
                    backgroundColor: Colors.orange.shade300,
                    collapsedBackgroundColor: Colors.orange.shade300,
                    collapsedShape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    title: Text(
                      "Rangkuman",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.expand_more,
                      color: Colors.white,
                    ),
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.orange.shade100,
                        ),
                        child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            children: [
                              const TextSpan(
                                text: "Basal Metabolic Rate anda adalah ",
                              ),
                              TextSpan(
                                text:
                                    "${NumberFormat('#,###').format(bmrValue)} kkal",
                                style: TextStyle(
                                  color: Colors.orange.shade800,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const TextSpan(
                                text:
                                    ". BMR adalah konsumsi kalori harian tubuh untuk menjalankan fungsi hidup dasar seperti, bernafas, sirkulasi darah dan fungsi organ. Sedangkan, berdasarkan level aktifitas harian yang anda pilih, TDEE atau kebutuhan kalori harian anda adalah ",
                              ),
                              TextSpan(
                                text:
                                    "${NumberFormat('#,###').format(tdeeValue)} kkal",
                                style: TextStyle(
                                  color: Colors.orange.shade800,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const TextSpan(
                                text:
                                    ". Pastikan pola makan harian anda mencukupi untuk memenuhi kebutuhan kalori harian anda karena dapat menyebabkan malnutrisi dan gangguan metabolisme.",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(14),
                  ExpansionTile(
                    backgroundColor: Colors.red.shade400,
                    collapsedBackgroundColor: Colors.red.shade400,
                    collapsedShape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    title: Text(
                      "Penyesuaian Berdasarkan Tujuan",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.expand_more,
                      color: Colors.white,
                    ),
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.red.shade100,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Menurunkan berat badan",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: Colors.red.shade700,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "(10%-20% dibawah TDEE)",
                              style: GoogleFonts.poppins(
                                color: Colors.red.shade700,
                                fontSize: 11,
                              ),
                            ),
                            const Gap(8),
                            Text(
                              "Untuk menurunkan berat badan, Anda perlu defisit kalori. Disarankan konsumsi sekitar ${tdeeValue - (tdeeValue * 0.1).toInt()} - ${tdeeValue - (tdeeValue * 0.2).toInt()} kkal per hari.",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                              ),
                            ),
                            const Gap(10),
                            Text(
                              "Menambah berat badan",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: Colors.red.shade700,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "(10%-20% diatas TDEE)",
                              style: GoogleFonts.poppins(
                                color: Colors.red.shade700,
                                fontSize: 11,
                              ),
                            ),
                            const Gap(8),
                            Text(
                              "Untuk menaikkan berat badan, Anda perlu defisit kalori. Disarankan konsumsi sekitar ${tdeeValue + (tdeeValue * 0.1).toInt()} - ${tdeeValue + (tdeeValue * 0.2).toInt()} kkal per hari.",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Gap(14),
                  ExpansionTile(
                    backgroundColor: Colors.green.shade400,
                    collapsedBackgroundColor: Colors.green.shade400,
                    collapsedShape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    title: Text(
                      "Tips Kesehatan Metabolism",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.expand_more,
                      color: Colors.white,
                    ),
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.green.shade100,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Pola Makan Sehat
                            Row(
                              children: [
                                Icon(
                                  Icons.restaurant_menu,
                                  color: Colors.green.shade700,
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    "Pola Makan Sehat",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green.shade700,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Konsumsi makanan seimbang yang mencakup karbohidrat, protein, dan lemak sehat.",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                              ),
                            ),

                            const Gap(10),

                            // Hidrasi
                            Row(
                              children: [
                                Icon(
                                  Icons.water_drop,
                                  color: Colors.green.shade700,
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    "Hidrasi",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green.shade700,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Minum air minimal 8 gelas per hari untuk mendukung metabolisme tubuh.",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                              ),
                            ),

                            const Gap(10),

                            // Istirahat Cukup
                            Row(
                              children: [
                                Icon(
                                  Icons.bedtime,
                                  color: Colors.green.shade700,
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    "Istirahat Cukup",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green.shade700,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Tidur yang cukup (7–9 jam per malam) dapat membantu mengoptimalkan metabolisme.",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Gap(14),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            useIcon: false,
                            onPressed: () {
                              context.go(' /home');
                            },
                            color: Colors.transparent,
                            border: Border.all(
                              color: AppColors.primary,
                              width: 2,
                            ),
                            captionStyle: context.textTheme.bodyLarge?.copyWith(
                              fontSize: 12,
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                            caption: "Keluar",
                          ),
                        ),
                        const Gap(12),
                        Expanded(
                          child: BlocProvider(
                            create: (context) => CalorieCubit(),
                            child: BlocConsumer<CalorieCubit, CalorieState>(
                              listener: (context, state) {
                                if (state is SaveCalorieLoading) {
                                  context.showCustomDialog(
                                    content: loadingContentDialog(
                                        context: context,
                                        message: "Menyimpan produk"),
                                  );
                                } else if (state is SaveCalorieSuccess) {
                                  context.showCustomDialog(
                                    content: infoContentDialog(
                                      context: context,
                                      title:
                                          "BMR dan TDEE anda telah diupdate!",
                                      onConfirm: () {
                                        context.go('/home');
                                      },
                                    ),
                                  );
                                } else if (state is SaveCalorieError) {
                                  Navigator.of(context).pop();
                                  context
                                      .showSnackbar(state.message ?? "error");
                                }
                              },
                              builder: (context, state) {
                                return AppButton(
                                  useIcon: false,
                                  onPressed: () {
                                    context
                                        .read<CalorieCubit>()
                                        .saveUserCalories(
                                            bmr: bmrValue.toDouble(),
                                            tdee: tdeeValue.toDouble());
                                  },
                                  caption: "Simpan",
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container itemCalories(
    BuildContext context,
    int data,
    String title,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: const GradientBoxBorder(
          gradient: AppColors.greenGradient,
          width: 8,
        ),
      ),
      child: Column(
        children: [
          Text(
            data.toString(),
            style: context.textTheme.titleLarge,
          ),
          const Gap(8),
          Text(
            title,
            style: context.textTheme.bodyLarge?.copyWith(
              color: AppColors.ancient,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
