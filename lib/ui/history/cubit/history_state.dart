part of 'history_cubit.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

class GetHistoryLoading extends HistoryState {}

class GetHistorySuccess extends HistoryState {
  final int totalScanned;
  final int totalHighSugar;
  final int totalHighSalt;
  final double todaySugar;
  final double todaySalt;
  final double weeklySugar;
  final double weeklySalt;
  final List<ScannedProduct> scannedProduct;
  final List<ScannedProduct> todayScannedProducts;
  final Map<String, List<ScannedProduct>> weeklyGroupedProducts;

  const GetHistorySuccess({
    required this.totalScanned,
    required this.totalHighSugar,
    required this.totalHighSalt,
    required this.todaySugar,
    required this.todaySalt,
    required this.weeklySugar,
    required this.weeklySalt,
    required this.scannedProduct,
    required this.todayScannedProducts,
    required this.weeklyGroupedProducts,
  });

  @override
  List<Object> get props => [
        totalScanned,
        totalHighSugar,
        totalHighSalt,
        todaySugar,
        todaySalt,
        weeklySalt,
        weeklySugar,
        scannedProduct,
        todayScannedProducts,
        weeklyGroupedProducts,
      ];
}

class GetHistoryError extends HistoryState {
  final String message;

  const GetHistoryError({required this.message});

  @override
  List<Object> get props => [message];
}
