import 'dart:developer';

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
        List<ScannedProduct> todayScannedProducts = [];
        Map<String, List<ScannedProduct>> weeklyGroupedProducts = {};
        int totalScanned = 0;
        int totalHighSugar = 0;
        int totalHighSalt = 0;
        double todaySugar = 0.0;
        double todaySalt = 0.0;
        double weeklySugar = 0.0;
        double weeklySalt = 0.0;

        var scannedProductsData =
            doc.data()?['scanned_products'] as List<dynamic>?;

        if (scannedProductsData != null) {
          // Convert to ScannedProduct list
          scannedProducts = scannedProductsData
              .map((e) => ScannedProduct.fromMap(e as Map<String, dynamic>))
              .toList()
            ..sort((a, b) => b.timeStamp.compareTo(a.timeStamp));

          // Total Scanned
          totalScanned = scannedProducts.length;

          // Total high sugar and salt products
          totalHighSugar = scannedProducts
              .where((product) => product.isSugarHighest == true)
              .length;
          totalHighSalt = scannedProducts
              .where((product) => product.isSugarHighest == false)
              .length;

          // Filter today's products
          final today = DateTime.now();
          todayScannedProducts = scannedProducts.where((product) {
            final date = product.timeStamp;
            return date.year == today.year &&
                date.month == today.month &&
                date.day == today.day;
          }).toList();

          // Calculate today's sugar and salt
          for (var product in todayScannedProducts) {
            todaySugar += product.totalSugar;
            todaySalt += product.totalSalt;
          }

          // Calculate weekly sugar and salt
          final startOfWeek = today.subtract(Duration(days: today.weekday - 1));
          final endOfWeek = startOfWeek.add(const Duration(days: 6));
          scannedProducts.where((product) {
            final date = product.timeStamp;
            return date.isAfter(startOfWeek) && date.isBefore(endOfWeek);
          }).forEach((product) {
            weeklySugar += product.totalSugar;
            weeklySalt += product.totalSalt;
          });

          // Group products by weekly periods
          scannedProducts
              .where((product) =>
                  product.timeStamp.isBefore(today) &&
                  product.timeStamp
                      .isAfter(today.subtract(const Duration(days: 30))))
              .forEach((product) {
            DateTime weekStart = product.timeStamp
                .subtract(Duration(days: product.timeStamp.weekday - 1));
            String weekLabel = "${weekStart.day.toString().padLeft(2, '0')} "
                "${_getMonthAbbreviation(weekStart)} - "
                "${weekStart.add(Duration(days: 6)).day.toString().padLeft(2, '0')} "
                "${_getMonthAbbreviation(weekStart.add(Duration(days: 6)))} "
                "${weekStart.year}";

            if (!weeklyGroupedProducts.containsKey(weekLabel)) {
              weeklyGroupedProducts[weekLabel] = [];
            }
            weeklyGroupedProducts[weekLabel]!.add(product);
          });
        }

        emit(GetHistorySuccess(
          totalScanned: totalScanned,
          totalHighSugar: totalHighSugar,
          totalHighSalt: totalHighSalt,
          todaySugar: todaySugar,
          todaySalt: todaySalt,
          weeklySugar: weeklySugar,
          weeklySalt: weeklySalt,
          scannedProduct: scannedProducts,
          todayScannedProducts: todayScannedProducts,
          weeklyGroupedProducts: weeklyGroupedProducts,
        ));
      } else {
        emit(const GetHistorySuccess(
          totalScanned: 0,
          totalHighSugar: 0,
          totalHighSalt: 0,
          todaySugar: 0,
          todaySalt: 0,
          weeklySugar: 0,
          weeklySalt: 0,
          scannedProduct: [],
          todayScannedProducts: [],
          weeklyGroupedProducts: {},
        ));
      }
    } catch (e) {
      emit(GetHistoryError(message: e.toString()));
    }
  }

  // Helper method to get month abbreviation
  String _getMonthAbbreviation(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[date.month - 1];
  }
}
