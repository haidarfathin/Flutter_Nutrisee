import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/core/widgets/app_theme.dart';
import 'package:nutrisee/ui/article/cubit/article_cubit.dart';
import 'package:nutrisee/ui/article/widgets/article_item.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArticleCubit()..fetchArticle(),
      child: Scaffold(
        backgroundColor: AppColors.whiteBG,
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              const SliverAppBar(
                scrolledUnderElevation: 0,
                title: Text("Artikel"),
                pinned: true,
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.marginHorizontal,
                  vertical: AppTheme.marginVertical,
                ),
                sliver: BlocBuilder<ArticleCubit, ArticleState>(
                  builder: (context, state) {
                    if (state is ArticleLoading) {
                      return const SliverFillRemaining(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else if (state is ArticleSuccess) {
                      final articles = state.data?.articles ?? [];
                      return SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20.0,
                          crossAxisSpacing: 20.0,
                          childAspectRatio: 0.7,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            final article = articles[index];
                            return ArticleItem(article: article);
                          },
                          childCount: articles.length,
                        ),
                      );
                    } else if (state is ArticleError) {
                      return SliverFillRemaining(
                        child: Center(child: Text(state.message!)),
                      );
                    }
                    return const SliverFillRemaining(
                      child: Center(child: Text('No Articles')),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
