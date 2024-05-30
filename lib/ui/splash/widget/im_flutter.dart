import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nutrisee/gen/assets.gen.dart';

class ImFlutter extends StatelessWidget {
  const ImFlutter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Assets.images.icLogo.image(height: 50),
    );
  }
}
