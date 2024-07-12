import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:nutrisee/core/data/model/firestore/barcode_product.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/ui/scan_product/screen/add_barcode_screen.dart';
import 'package:nutrisee/ui/scan_product/screen/detail_barcode_product.dart';

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({super.key});

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  MobileScannerController cameraController =
      MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates);
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    void _onBarcodeDetected(Barcode barcode) async {
      if (barcode.rawValue != null && barcode.rawValue!.length >= 12) {
        log(barcode.rawValue ?? "No Data found in QR");
        setState(() {
          isLoading = true;
        });

        bool snapshotFound = false;

        try {
          DocumentSnapshot snapshot = await FirebaseFirestore.instance
              .collection('products')
              .doc(barcode.rawValue!)
              .get();

          if (snapshot.exists) {
            final data = snapshot.data() as Map<String, dynamic>;
            final product = BarcodeProduct.fromMap(data);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailBarcodeProduct(
                  nutritionData: product,
                ),
              ),
            );
            snapshotFound = true;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Product tidak ada")),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: $e")),
          );
        } finally {
          if (!snapshotFound) {
            // Show dialog if snapshot not found after 5 seconds
            Future.delayed(Duration(seconds: 5), () {
              if (!snapshotFound) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text("Produk Belum Tersedia"),
                    content: Text(
                        "Ingin berkontribusi dengan menambahkan produk baru?"),
                    actions: [
                      TextButton(
                        child: Text("Batal"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text("OK"),
                        onPressed: () {
                          // Add logic for contributing
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddBarcodeScreen(
                                barcodeNumber: barcode.rawValue!,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }
            });
          }

          setState(() {
            isLoading = false;
          });
        }
      }
    }

    return Scaffold(
      backgroundColor: AppColors.textBlack,
      appBar: AppBar(
        title: const Text("Pindai Barcode Produk"),
        scrolledUnderElevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(40),
              child: Container(
                height: 150,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Stack(
                  children: [
                    MobileScanner(
                      controller: cameraController,
                      onDetect: (capture) {
                        if (!isLoading) {
                          final List<Barcode> barcodes = capture.barcodes;
                          for (final barcode in barcodes) {
                            _onBarcodeDetected(barcode);
                            break; // Process only the first barcode detected
                          }
                        }
                      },
                    ),
                    if (isLoading)
                      Container(
                        color: Colors.black54,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
