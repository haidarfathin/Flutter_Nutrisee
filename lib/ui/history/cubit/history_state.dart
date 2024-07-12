part of 'history_cubit.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

class GetHistoryLoading extends HistoryState {}

class GetHistorySuccess extends HistoryState {
  final List<ScannedProduct> scannedProduct;
  final int? totalScanned;
  final int? totalHighSugar;
  final int? totalHighNatrium;

  GetHistorySuccess(
    this.totalScanned,
    this.totalHighSugar,
    this.totalHighNatrium, {
    required this.scannedProduct,
  });

  @override
  List<Object> get props => [
        scannedProduct,
        totalScanned ?? 0,
        totalHighNatrium ?? 0,
        totalHighSugar ?? 0,
      ];
}

class GetHistoryError extends HistoryState {
  final String message;

  const GetHistoryError({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
