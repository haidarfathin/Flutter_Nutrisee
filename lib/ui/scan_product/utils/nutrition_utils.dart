import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:nutrisee/gen/assets.gen.dart';

class NutritionUtils {
  static final FlutterTts _textToSpeech = FlutterTts();

  // Constants for thresholds
  static const double garamLimit = 2000.0; // in mg
  static const double gulaLimit = 50.0; // in grams
  static const double garamWarningThreshold = 0.25; // 25%
  static const double gulaWarningThreshold = 0.25; // 25%

  /// Get Nutri-Score image based on salt, sugar, and fat per serving
  static Widget getNutriScoreImage(int garam, int gula, int lemak, int sajian) {
    final double garamSajian = garam * sajian / 1000; // Convert mg to grams
    final int gulaSajian = gula * sajian;
    final int lemakSajian = lemak * sajian;

    if (garamSajian < gulaSajian) {
      return _getGulaScoreImage(gulaSajian, lemakSajian);
    } else {
      return _getGaramScoreImage(garamSajian);
    }
  }

  static Widget _getGulaScoreImage(int gulaSajian, int lemakSajian) {
    if (gulaSajian <= 5 && lemakSajian <= 1) {
      return Assets.images.icScoreA.image();
    }
    if (gulaSajian <= 10 && lemakSajian <= 2) {
      return Assets.images.icScoreB.image();
    }
    if (gulaSajian <= 15 && lemakSajian <= 3) {
      return Assets.images.icScoreC.image();
    }
    return Assets.images.icScoreD.image();
  }

  static Widget _getGaramScoreImage(double garamSajian) {
    if (garamSajian <= 0.5) return Assets.images.icScoreA.image();
    if (garamSajian <= 1.0) return Assets.images.icScoreB.image();
    if (garamSajian <= 1.5) return Assets.images.icScoreC.image();
    return Assets.images.icScoreD.image();
  }

  /// Get nutrition score as a string (A, B, C, D)
  static String getNutriScoreString(
      int garam, int gula, int lemak, int sajian) {
    final double garamSajian = garam * sajian / 1000;
    final int gulaSajian = gula * sajian;
    final int lemakSajian = lemak * sajian;

    if (garamSajian < gulaSajian) {
      return _getGulaScoreString(gulaSajian, lemakSajian);
    } else {
      return _getGaramScoreString(garamSajian);
    }
  }

  static String _getGulaScoreString(int gulaSajian, int lemakSajian) {
    if (gulaSajian <= 5 && lemakSajian <= 1) return "A";
    if (gulaSajian <= 10 && lemakSajian <= 2) return "B";
    if (gulaSajian <= 15 && lemakSajian <= 3) return "C";
    return "D";
  }

  static String _getGaramScoreString(double garamSajian) {
    if (garamSajian <= 0.5) return "A";
    if (garamSajian <= 1.0) return "B";
    if (garamSajian <= 1.5) return "C";
    return "D";
  }

  /// Examine nutrition status and return image with vibration and speech
  static Widget examineImage(int garam, int gula, int sajian,
      {bool enableVibrationAndSpeech = true}) {
    final double garamSajian = garam * sajian / 1000;
    final double gulaSajian = gula * sajian.toDouble();

    final String title = examineNutritionTitle(garam, gula, sajian);

    if (enableVibrationAndSpeech) {
      _handleVibrationAndSpeech(title, garamSajian, gulaSajian);
    }

    switch (title) {
      case "Kandungan Garam Tinggi":
        return garamSajian > 2.0
            ? Assets.images.scoreD.image()
            : Assets.images.scoreC.image();
      case "Kandungan Gula Tinggi":
        return gulaSajian > 12.0
            ? Assets.images.scoreD.image()
            : Assets.images.scoreC.image();
      default:
        return Assets.images.icApprove.image();
    }
  }

  static String examineNutritionTitle(int garam, int gula, int sajian) {
    final double garamSajian = garam * sajian / 1000;
    final double gulaSajian = gula * sajian.toDouble();

    final double garamProporsi = garamSajian / garamLimit;
    final double gulaProporsi = gulaSajian / gulaLimit;

    if (garamProporsi > gulaProporsi) {
      return garamProporsi >= garamWarningThreshold
          ? "Kandungan Garam Tinggi"
          : "Produk Aman Dikonsumsi";
    } else {
      return gulaProporsi >= gulaWarningThreshold
          ? "Kandungan Gula Tinggi"
          : "Produk Aman Dikonsumsi";
    }
  }

  static void _handleVibrationAndSpeech(
      String title, double garamSajian, double gulaSajian) {
    if (title == "Kandungan Garam Tinggi" && garamSajian > 1.5) {
      _vibrate(pattern: [500, 2000, 500]);
      _speak("Garam tinggi ${garamSajian.toStringAsFixed(2)} gram.");
    } else if (title == "Kandungan Gula Tinggi" && gulaSajian > 6.0) {
      _vibrate(pattern: [500, 2000, 500]);
      _speak("Gula tinggi ${gulaSajian.toStringAsFixed(2)} gram.");
    }
  }

  static Future<void> _speak(String text) async {
    await _textToSpeech.setLanguage("id");
    await _textToSpeech.setPitch(1);
    await _textToSpeech.speak(text);
  }

  static void _vibrate({required List<int> pattern}) {
    Vibration.vibrate(pattern: pattern);
  }
}
