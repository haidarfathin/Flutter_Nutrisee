import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nutrisee/core/data/model/article/article.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';

class ArticleItem extends StatelessWidget {
  final Article article;

  const ArticleItem({required this.article, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 15,
            offset: const Offset(1, 3),
          ),
        ],
        border: Border.all(
          color: AppColors.grayBG,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(40),
              ),
            ),
            clipBehavior: Clip.hardEdge,
            child: article.urlToImage == ""
                ? Image.asset(
                    "assets/images/ic_placeholder.png",
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    article.urlToImage!,
                    fit: BoxFit.cover,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title ?? 'No Title',
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 3,
                ),
                const Gap(6),
                Text(
                  article.description ?? 'No Description',
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontSize: 10,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
