import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:nutrisee/core/config/config.dart';
import 'package:nutrisee/core/data/model/firestore/barcode_product.dart';
import 'package:nutrisee/core/data/model/firestore/scanned_products.dart';
import 'package:nutrisee/core/data/model/firestore/user_data.dart';
import 'package:nutrisee/core/data/model/product_nutrition.dart';
import 'package:nutrisee/core/data/prompt.dart';
import 'package:nutrisee/core/utils/session.dart';

part 'scan_product_state.dart';

class ScanProductCubit extends Cubit<ScanProductState> {
  ScanProductCubit() : super(ScanProductInitial());
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final session = Session();
  UploadTask? uploadTask;

  void analyzeProduct(String imagePath) async {
    emit(AnalyzeProductLoading());
    try {
      final file = File(imagePath);

      // final compressedImage = await ImageCompress().compressFile(file);
      final bytes = file.readAsBytesSync();

      // final result = await gemini.textAndImage(
      //   text: Prompt.jsonProductPrompt,
      //   images: [bytes],
      // );

      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: Config.geminiKey,
      );

      final prompt = TextPart(Prompt.jsonProductPrompt);
      final imageParts = [DataPart('image/jpeg', bytes)];
      final response = await model.generateContent([
        Content.multi([prompt, ...imageParts])
      ]);

      final rawText = response.text.toString();
      final jsonString =
          rawText.replaceAll('```json', '').replaceAll('```', '').trim();

      log(jsonString); // Untuk debugging

      final jsonResponse = json.decode(jsonString);
      final productNutrition = ProductNutrition.fromMap(jsonResponse);
      log(productNutrition.toString());

      //get user data
      final userId = await session.read(Config.getUser);
      log("userid $userId");

      if (userId != null) {
        DocumentSnapshot userDoc =
            await firestore.collection("users").doc(userId).get();
        UserData userData =
            UserData.fromMap(userDoc.data() as Map<String, dynamic>);
        log(userData.toString());
        emit(AnalyzeProductSuccess(productNutrition, userData));
      }
    } catch (e) {
      emit(AnalyzeProductError("Gagal mengekstrak nutrisi dari gambar: $e"));
    }
  }

  void saveScannedProduct(
      {required XFile image,
      required bool isSugarHighest,
      required String name,
      required String score,
      required double salt,
      required double sugar,
      required double fat,
      required double sajian,
      required DateTime timestamp}) async {
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
        salt: salt,
        totalSalt: salt * sajian,
        totalSugar: sugar * sajian,
        sugar: sugar,
        fat: fat,
        timeStamp: timestamp,
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
