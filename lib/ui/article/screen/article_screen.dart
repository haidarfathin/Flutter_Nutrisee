import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/core/widgets/app_search_bar.dart';
import 'package:nutrisee/core/widgets/app_theme.dart';
import 'package:nutrisee/ui/article/widgets/article_item.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBG,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.marginHorizontal,
          ),
          child: CustomScrollView(
            slivers: <Widget>[
              const SliverAppBar(
                scrolledUnderElevation: 0,
                title: Text("Artikel"),
                collapsedHeight: 130,
                pinned: true,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(0.0),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 20,
                    ),
                    child: AppSearchBar(
                      hint: "Search",
                    ),
                  ),
                ),
              ),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  childAspectRatio: 0.7,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ArticleItem();
                  },
                  childCount: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
