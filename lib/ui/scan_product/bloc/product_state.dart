part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class AnalyzeProductLoading extends ProductState {}

class AnalyzeProductSuccess extends ProductState {
  final ProductNutrition productNutrition;

  const AnalyzeProductSuccess(this.productNutrition);

  @override
  List<Object> get props => [productNutrition];
}

class AnalyzeProductError extends ProductState {
  final String error;

  const AnalyzeProductError(this.error);

  @override
  List<Object> get props => [error];
}
