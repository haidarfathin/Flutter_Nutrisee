part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class AnalyzeProduct extends ProductEvent {
  final String imagePath;
  const AnalyzeProduct(this.imagePath);

  @override
  List<Object> get props => [imagePath];
}
