part of 'article_cubit.dart';

abstract class ArticleState extends Equatable {
  const ArticleState();

  @override
  List<Object> get props => [];
}

class ArticleInitial extends ArticleState {}

class ArticleLoading extends ArticleState {}

class ArticleSuccess extends ArticleState {
  final ArticleData? data;
  final String? message;

  const ArticleSuccess({
    this.data,
    this.message,
  });

  @override
  List<Object> get props => [data ?? ArticleData()];
}

class ArticleError extends ArticleState {
  final String? message;

  ArticleError({required this.message});
}
