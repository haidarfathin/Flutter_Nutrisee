import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nutrisee/gen/assets.gen.dart';

class ImLogo extends StatelessWidget {
  const ImLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Assets.images.icLauncher.image(height: 150),
    );
  }
}
