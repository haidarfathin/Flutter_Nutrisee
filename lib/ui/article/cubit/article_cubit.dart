import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrisee/core/config/config.dart';
import 'package:nutrisee/core/data/datasource/api/api_service.dart';
import 'package:nutrisee/core/data/model/article/article.dart';
import 'package:nutrisee/di/injection.dart';

part 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  ArticleCubit() : super(ArticleInitial());
  ApiService api = getIt<ApiService>();

  void fetchArticle() async {
    emit(ArticleLoading());
    try {
      final response = await api.getArticle(Config.apiKey);
      emit(ArticleSuccess(data: response));
    } catch (e) {
      emit(ArticleError(message: e.toString()));
    }
  }
}
