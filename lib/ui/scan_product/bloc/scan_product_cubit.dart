import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:nutrisee/core/data/model/firestore/barcode_product.dart';
import 'package:nutrisee/core/data/model/firestore/scanned_products.dart';
import 'package:nutrisee/core/data/model/product_nutrition.dart';
import 'package:nutrisee/core/data/prompt.dart';
import 'package:nutrisee/core/utils/session.dart';

import '../../../core/utils/image_compress.dart';

part 'scan_product_state.dart';

class ScanProductCubit extends Cubit<ScanProductState> {
  ScanProductCubit() : super(ScanProductInitial());
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final session = Session();
  final gemini = Gemini.instance;
  UploadTask? uploadTask;

  void analyzeProduct(String imagePath) async {
    emit(AnalyzeProductLoading());
    try {
      final file = File(imagePath);

      // final compressedImage = await ImageCompress().compressFile(file);
      final bytes = file.readAsBytesSync();

      final result = await gemini.textAndImage(
        text: Prompt.jsonProductPrompt,
        images: [bytes],
      );

      log('Result: ${result?.content?.parts?.last.text}');

      final rawText = result?.content?.parts?.last.text ?? '{}';
      final response = json.decode(rawText);
      final productNutrition = ProductNutrition.fromMap(response);
      log(productNutrition.toString());
      emit(AnalyzeProductSuccess(productNutrition));
    } catch (e) {
      // emit(AnalyzeProductError("Gagal mengekstrak nutrisi dari gambar: $e"));
    }
  }

  void saveScannedProduct({
    required XFile image,
    required bool isSugarHighest,
    required String name,
    required String score,
    required double natrium,
    required double sugar,
    required double fat,
  }) async {
    emit(ProductAddLoading());
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      log("userid product $userId");

      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      Reference ref = FirebaseStorage.instance.ref();
      Reference refDirImages = ref.child('product_image');
      Reference refImage = refDirImages.child(fileName);

      String? urlDownload;

      try {
        await refImage.putFile(File(image.path));
        urlDownload = await refImage.getDownloadURL();
      } catch (e) {
        log(e.toString());
        emit(ProductAddError("Failed to upload image: $e"));
        return;
      }

      ScannedProduct scannedProduct = ScannedProduct(
        image: urlDownload,
        isSugarHighest: isSugarHighest,
        name: name,
        score: score,
        natrium: natrium,
        sugar: sugar,
        fat: fat,
      );

      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userId);

      DocumentSnapshot userDocSnapshot = await userDocRef.get();

      if (userDocSnapshot.exists) {
        await userDocRef.update({
          'scanned_products': FieldValue.arrayUnion([scannedProduct.toMap()])
        });
      } else {
        await userDocRef.set({
          'scanned_products': [scannedProduct.toMap()],
        });
      }

      emit(ProductAddedSuccess());
    } catch (e) {
      emit(ProductAddError(e.toString()));
    }
  }

  void fetchProductByBarcode(String barcode) async {
    emit(FetchProductLoading());
    try {
      DocumentSnapshot snapshot =
          await firestore.collection('products').doc(barcode).get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        final product = BarcodeProduct.fromMap(data);
        log(product.toString());
        emit(FetchProductSuccess(product));
      } else {
        emit(const FetchProductError("Product not found"));
      }
    } catch (e) {
      emit(FetchProductError("Failed to fetch product: $e"));
    }
  }
}
