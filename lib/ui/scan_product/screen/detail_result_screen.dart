import 'package:flutter/material.dart';
import 'package:nutrisee/gen/assets.gen.dart';

class DetailResultScreen extends StatefulWidget {
  const DetailResultScreen({super.key});

  @override
  State<DetailResultScreen> createState() => _DetailResultScreenState();
}

class _DetailResultScreenState extends State<DetailResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("Detail Produk"),
            centerTitle: true,
            scrolledUnderElevation: 0,
          ),
          SliverToBoxAdapter(
            child: Assets.images.imgArticle.image(
              height: 100,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}
