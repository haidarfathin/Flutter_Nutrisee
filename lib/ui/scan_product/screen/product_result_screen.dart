import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_button.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/core/widgets/app_theme.dart';
import 'package:nutrisee/ui/scan_product/widget/nutrition_container.dart';

class ProductResultScreen extends StatefulWidget {
  final String imagePath;

  const ProductResultScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  _ProductResultScreenState createState() => _ProductResultScreenState();
}

class _ProductResultScreenState extends State<ProductResultScreen> {
  // final gemini = Gemini.instance;
  // String analysisResult = "load";

  // @override
  // void initState() {
  //   super.initState();
  //   analyzeImage();
  // }

  // Future<void> analyzeImage() async {
  //   try {
  //     final file = File(widget.imagePath);
  //     final bytes = file.readAsBytesSync();

  //     // Custom prompt for analysis
  //     const customPrompt =
  //         "Berdasarkan tabel informasi nilai gizi, analisa kandungan total energi, gula, natrium, dan lemak jenuh total dari produk ini. "
  //         "Berikan penilaian terhadap produk ini dengan ketentuan berikut berdasarkan takaran saji yang sesuai: "
  //         "A untuk produk dengan kandungan (gula <= 1 gr dan lemak jenuh <= 0.7 gr) per 100 gram "
  //         "B untuk produk dengan kandungan (1 gr < gula <= 5 gr dan lemak jenuh <= 1.2 gr) per 100 gram "
  //         "C untuk produk dengan kandungan (5 gr < gula <= 10 gr dan lemak jenuh <= 2.8 gr) per 100 gram "
  //         "D untuk produk dengan kandungan (gula > 10 gr dan lemak jenuh > 2.8 gr) per 100 gram. "
  //         "Penilaian harus disesuaikan dengan takaran saji yang ada pada produk. "
  //         "Berikan juga saran singkat untuk berolahraga untuk menghabiskan kalori dari produk ini, dengan saran berupa jalan kaki atau bersepeda."
  //         "Misalnya, jika produk memiliki takaran saji 50 gram, nilai kandungan harus disesuaikan sehingga penilaian tetap akurat. "
  //         "Gunakan template berikut untuk memberikan hasil analisa: "
  //         "Skor produk = [penilaian]\n\n"
  //         "Berdasarkan tabel informasi nilai gizi, kandungan gula, natrium, dan lemak jenuh total produk adalah sebagai berikut:\n"
  //         "- Gula: [nilai gula] gram\n"
  //         "- Natrium: [nilai natrium] mg\n"
  //         "- Lemak Jenuh: [nilai lemak jenuh] gram\n\n"
  //         "Dengan mengonsumsi [ceil(50 : nilai gula)] produk ini dalam sehari anda telah "
  //         "melampaui batas konsumsi gula harian yaitu 50 gram "
  //         "atau 4 sendok makan tiap harinya\n\n";

  //     final result = await gemini.textAndImage(
  //       text: customPrompt,
  //       images: [bytes],
  //     );

  //     if (mounted) {
  //       setState(() {
  //         analysisResult =
  //             result?.content?.parts?.last.text ?? 'No analysis available';
  //       });
  //     }
  //   } catch (e) {
  //     log('textAndImageInput', error: e);
  //     if (mounted) {
  //       setState(() {
  //         analysisResult = 'Error analyzing image';
  //       });
  //     }
  //   }
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hasil Analisa Produk"),
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Image.file(File(widget.imagePath))],
            ),
            DraggableScrollableSheet(
              maxChildSize: 0.5,
              builder: (BuildContext context, scrollController) {
                return Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: contentContainer(
                        context, scrollController, analysisResult),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

bool showWarning(String analysisText) {
  final scoreRegex = RegExp(r'Skor produk = ([A-D])');
  final match = scoreRegex.firstMatch(analysisText);
  if (match != null) {
    final score = match.group(1);
    if (score == 'C' || score == 'D') {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}

Widget contentContainer(
  BuildContext context,
  ScrollController controller,
  String analysisResult,
) {
  return CustomScrollView(
    controller: controller,
    slivers: [
      // const SliverAppBar(
      //   title: Text(
      //     'Analisa Produk',
      //     style: TextStyle(
      //       color: AppColors.primary,
      //     ),
      //   ),
      //   primary: false,
      //   pinned: true,
      //   centerTitle: false,
      //   automaticallyImplyLeading: false,
      //   scrolledUnderElevation: 0,
      // ),

      // showWarning(analysisResult)
      //     ? SliverToBoxAdapter(
      //         child: Container(
      //             padding: const EdgeInsets.all(14),
      //             alignment: Alignment.center,
      //             color: AppColors.orangeSwatch.shade400,
      //             child: Text(
      //               "Produk ini tidak baik dikonsumsi berlebihan",
      //               style: context.textTheme.bodyLarge?.copyWith(
      //                 color: Colors.white,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             )))
      //     : SliverToBoxAdapter(
      //         child: Container(),
      //       ),
      SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NutritionContainer(
              kandungan: 50,
              background: AppColors.orangeSwatch,
              title: "Gula",
              subtitle: "16gr",
            ),
            NutritionContainer(
              kandungan: 70,
              background: AppColors.orangeSwatch.shade300,
              title: "Lemak Jenuh",
              subtitle: "20gr",
            ),
            NutritionContainer(
              kandungan: 2000,
              background: AppColors.orangeSwatch.shade200,
              title: "Garam",
              subtitle: "30mg",
            ),
          ],
        ),
      ),
      // analysisResult == "load"
      //     ? SliverFillRemaining(
      //         hasScrollBody: false,
      //         child: Center(
      //           child: CircularProgressIndicator(
      //             color: AppColors.primary,
      //           ),
      //         ),
      //       )
      //     : SliverList(
      //         delegate: SliverChildListDelegate([
      //           ListTile(
      //             title: Text(
      //               analysisResult,
      //               style: context.textTheme.bodyLarge,
      //             ),
      //           ),
      //         ]),
      //       ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(top: AppTheme.marginHorizontal),
          child: AppButton(
            onPressed: () {},
            caption: "Pelajari lebih lanjut",
          ),
        ),
      )
    ],
  );
}
