/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/ic_bulb.png
  AssetGenImage get icBulb => const AssetGenImage('assets/images/ic_bulb.png');

  /// File path: assets/images/ic_count.png
  AssetGenImage get icCount =>
      const AssetGenImage('assets/images/ic_count.png');

  /// File path: assets/images/ic_diabetes_test.png
  AssetGenImage get icDiabetesTest =>
      const AssetGenImage('assets/images/ic_diabetes_test.png');

  /// File path: assets/images/ic_diabetisi_no.png
  AssetGenImage get icDiabetisiNo =>
      const AssetGenImage('assets/images/ic_diabetisi_no.png');

  /// File path: assets/images/ic_diabetisi_yes.png
  AssetGenImage get icDiabetisiYes =>
      const AssetGenImage('assets/images/ic_diabetisi_yes.png');

  /// File path: assets/images/ic_launcher.png
  AssetGenImage get icLauncher =>
      const AssetGenImage('assets/images/ic_launcher.png');

  /// File path: assets/images/ic_logo.png
  AssetGenImage get icLogo => const AssetGenImage('assets/images/ic_logo.png');

  /// File path: assets/images/ic_nutriscore.png
  AssetGenImage get icNutriscore =>
      const AssetGenImage('assets/images/ic_nutriscore.png');

  /// File path: assets/images/ic_nutrition.png
  AssetGenImage get icNutrition =>
      const AssetGenImage('assets/images/ic_nutrition.png');

  /// File path: assets/images/ic_ocr.png
  AssetGenImage get icOcr => const AssetGenImage('assets/images/ic_ocr.png');

  /// File path: assets/images/ic_remind_med.png
  AssetGenImage get icRemindMed =>
      const AssetGenImage('assets/images/ic_remind_med.png');

  /// File path: assets/images/ic_scan_barcode.png
  AssetGenImage get icScanBarcode =>
      const AssetGenImage('assets/images/ic_scan_barcode.png');

  /// File path: assets/images/ic_warning.png
  AssetGenImage get icWarning =>
      const AssetGenImage('assets/images/ic_warning.png');

  /// File path: assets/images/ic_women_eat.png
  AssetGenImage get icWomenEat =>
      const AssetGenImage('assets/images/ic_women_eat.png');

  /// File path: assets/images/img_article.png
  AssetGenImage get imgArticle =>
      const AssetGenImage('assets/images/img_article.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        icBulb,
        icCount,
        icDiabetesTest,
        icDiabetisiNo,
        icDiabetisiYes,
        icLauncher,
        icLogo,
        icNutriscore,
        icNutrition,
        icOcr,
        icRemindMed,
        icScanBarcode,
        icWarning,
        icWomenEat,
        imgArticle
      ];
}

class $AssetsMapsGen {
  const $AssetsMapsGen();

  /// File path: assets/maps/style.json
  String get style => 'assets/maps/style.json';

  /// List of all assets
  List<String> get values => [style];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsMapsGen maps = $AssetsMapsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size = null});

  final String _assetName;

  final Size? size;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
