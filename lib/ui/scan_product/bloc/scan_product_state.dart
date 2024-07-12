part of 'scan_product_cubit.dart';

abstract class ScanProductState extends Equatable {
  const ScanProductState();

  @override
  List<Object> get props => [];
}

class ScanProductInitial extends ScanProductState {}

class AnalyzeProductLoading extends ScanProductState {}

class AnalyzeProductSuccess extends ScanProductState {
  final ProductNutrition productNutrition;

  const AnalyzeProductSuccess(this.productNutrition);

  @override
  List<Object> get props => [productNutrition];
}

class AnalyzeProductError extends ScanProductState {
  final String error;

  const AnalyzeProductError(this.error);

  @override
  List<Object> get props => [error];
}

class ProductAddLoading extends ScanProductState {}

class ProductAddedSuccess extends ScanProductState {}

class ProductAddError extends ScanProductState {
  final String error;

  const ProductAddError(this.error);

  @override
  List<Object> get props => [error];
}

class FetchProductLoading extends ScanProductState {}

class FetchProductSuccess extends ScanProductState {
  final BarcodeProduct product;

  const FetchProductSuccess(this.product);

  @override
  List<Object> get props => [product];
}

class FetchProductError extends ScanProductState {
  final String message;

  const FetchProductError(this.message);

  @override
  List<Object> get props => [message];
}
