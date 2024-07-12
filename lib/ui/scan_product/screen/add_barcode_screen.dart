import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nutrisee/core/widgets/app_button.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/core/widgets/app_textfield.dart';
import 'package:nutrisee/ui/menu_screen.dart';
import 'package:nutrisee/core/data/model/firestore/barcode_product.dart';

class AddBarcodeScreen extends StatefulWidget {
  final String barcodeNumber;
  const AddBarcodeScreen({super.key, required this.barcodeNumber});

  @override
  State<AddBarcodeScreen> createState() => _AddBarcodeScreenState();
}

class _AddBarcodeScreenState extends State<AddBarcodeScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController barcodeController =
        TextEditingController(text: widget.barcodeNumber);
    TextEditingController nameController = TextEditingController();
    TextEditingController sugarController = TextEditingController();
    TextEditingController natriumController = TextEditingController();
    TextEditingController fatController = TextEditingController();
    TextEditingController sajianController = TextEditingController();
    TextEditingController takaranSajiController = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.whiteBG,
      appBar: AppBar(
        title: const Text("Add Barcode Product"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              AppTextField(
                hint: "Masukkan Nomor Barcode Produk",
                title: "Nomor Barcode",
                controller: barcodeController,
              ),
              const Gap(12),
              AppTextField(
                title: "Nama Produk",
                hint: "Masukkan Nama Produk",
                controller: nameController,
              ),
              const Gap(12),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      title: "Gula",
                      hint: "Masukkan Gula Produk",
                      controller: sugarController,
                    ),
                  ),
                  const Gap(20),
                  Expanded(
                    child: AppTextField(
                      title: "Garam",
                      hint: "Masukkan Garam Produk",
                      controller: natriumController,
                    ),
                  ),
                ],
              ),
              const Gap(12),
              AppTextField(
                hint: "Masukkan Lemak Jenuh produk",
                title: "Lemak Jenuh",
                controller: fatController,
              ),
              const Gap(12),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      title: "Takaran Saji",
                      hint: "Masukkan Takaran Saji",
                      controller: takaranSajiController,
                    ),
                  ),
                  const Gap(20),
                  Expanded(
                    child: AppTextField(
                      title: "Sajian Produk",
                      hint: "Masukkan Sajian Produk",
                      controller: sajianController,
                    ),
                  ),
                ],
              ),
              const Gap(50),
              AppButton(
                onPressed: () async {
                  final product = BarcodeProduct(
                    barcode: int.tryParse(widget.barcodeNumber)!,
                    name: nameController.text,
                    natrium: num.parse(natriumController.text),
                    sugar: num.parse(sugarController.text),
                    saturatedFat: num.parse(fatController.text),
                    takaranSaji: num.parse(takaranSajiController.text),
                    sajian: num.parse(sajianController.text),
                  );

                  await FirebaseFirestore.instance
                      .collection('products')
                      .doc(product.barcode.toString())
                      .set(product.toMap())
                      .then((_) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MenuScreen()),
                    );
                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error: $error")),
                    );
                  });
                },
                caption: "Upload Produk",
                useIcon: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
