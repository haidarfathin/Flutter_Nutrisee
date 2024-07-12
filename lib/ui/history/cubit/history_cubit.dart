import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrisee/core/data/model/firestore/scanned_products.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void getUserHistory() async {
    emit(GetHistoryLoading());
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final doc = await firestore.collection('users').doc(userId).get();

      if (doc.exists) {
        List<ScannedProduct> scannedProducts = [];
        int totalScanned = 0;
        int totalHighSugar = 0;
        int totalHighSalt = 0;

        var scannedProductsData =
            doc.data()?['scanned_products'] as List<dynamic>?;

        if (scannedProductsData != null) {
          scannedProducts = scannedProductsData
              .map((e) => ScannedProduct.fromMap(e as Map<String, dynamic>))
              .toList();
          totalScanned = scannedProducts.length;
          totalHighSugar = scannedProducts
              .where((product) => product.isSugarHighest == true)
              .length;
          totalHighSalt = scannedProducts
              .where((product) => product.isSugarHighest == false)
              .length;
        }

        emit(GetHistorySuccess(
          totalScanned,
          totalHighSugar,
          totalHighSalt,
          scannedProduct: scannedProducts,
        ));
      } else {
        emit(GetHistorySuccess(0, 0, 0, scannedProduct: []));
      }
    } catch (e) {
      emit(GetHistoryError(message: e.toString()));
    }
  }
}
