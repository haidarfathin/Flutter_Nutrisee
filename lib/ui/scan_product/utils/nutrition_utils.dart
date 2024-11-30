import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:nutrisee/gen/assets.gen.dart';

class NutritionUtils {
  static final FlutterTts _textToSpeech = FlutterTts();

  static const double garamLimit = 2.0; // in mg
  static const double gulaLimit = 50.0; // in grams
  static const double garamWarningThreshold = 0.25; // 25%
  static const double gulaWarningThreshold = 0.25; // 25%

  /// Get Nutri-Score image based on salt, sugar, and fat per serving
  static Widget getNutriScoreImage(double garam, double gula, double lemak,
      double sajian, bool hasHipertensi, bool hasDiabetes) {
    final double garamSajian = (garam * sajian) / 1000; // Convert mg to grams
    final double gulaSajian = gula * sajian;
    final double lemakSajian = (lemak * sajian) / 10;

    if (garamSajian < gulaSajian) {
      return _getGulaScoreImage(gulaSajian, lemakSajian, hasDiabetes);
    } else {
      return _getGaramScoreImage(garamSajian, hasHipertensi);
    }
  }

  static Widget _getGulaScoreImage(
      double gulaSajian, double lemakSajian, bool hasDiabetes) {
    if (hasDiabetes) {
      if (gulaSajian < 2.5) {
        return Assets.images.icScoreA.image();
      }

      if (gulaSajian >= 2.5 && gulaSajian < 5) {
        return Assets.images.icScoreB.image();
      }

      if (gulaSajian >= 5 && gulaSajian < 7.5) {
        return Assets.images.icScoreC.image();
      }

      return Assets.images.icScoreD.image();
    } else {
      if (gulaSajian < 5) {
        return Assets.images.icScoreA.image();
      }

      if (gulaSajian >= 5 && gulaSajian < 10) {
        return Assets.images.icScoreB.image();
      }
      if (gulaSajian >= 10 && gulaSajian < 15) {
        return Assets.images.icScoreC.image();
      }
      return Assets.images.icScoreD.image();
    }
  }

  static Widget _getGaramScoreImage(double garamSajian, bool hasHipertensi) {
    if (hasHipertensi) {
      if (garamSajian < 0.5) return Assets.images.icScoreA.image();
      if (garamSajian >= 0.5 && garamSajian < 1) {
        return Assets.images.icScoreB.image();
      }
      if (garamSajian >= 1 && garamSajian < 1.5) {
        return Assets.images.icScoreC.image();
      }
      return Assets.images.icScoreD.image();
    } else {
      if (garamSajian < 0.5) return Assets.images.icScoreA.image();
      if (garamSajian >= 0.5 && garamSajian < 1.5) {
        return Assets.images.icScoreB.image();
      }
      if (garamSajian >= 1.5 && garamSajian < 2) {
        return Assets.images.icScoreC.image();
      }
      return Assets.images.icScoreD.image();
    }
  }

  /// Get nutrition score as a string (A, B, C, D)
  static String getNutriScoreString(double garam, double gula, double lemak,
      double sajian, bool hasHipertensi, bool hasDiabetes) {
    final double garamSajian = garam * sajian / 1000;
    final double gulaSajian = gula * sajian;
    final double lemakSajian = lemak * sajian;

    if (garamSajian < gulaSajian) {
      return _getGulaScoreString(gulaSajian, lemakSajian, hasDiabetes);
    } else {
      return _getGaramScoreString(garamSajian, hasHipertensi);
    }
  }

  static String _getGulaScoreString(
      double gulaSajian, double lemakSajian, bool hasDiabetes) {
    if (hasDiabetes) {
      if (gulaSajian < 2.5) return "A";
      if (gulaSajian >= 2.5 && gulaSajian < 5) return "B";
      if (gulaSajian >= 5 && gulaSajian < 7.5) return "C";

      return "D";
    } else {
      if (gulaSajian < 5) return "A";
      if (gulaSajian >= 5 && gulaSajian < 10) return "B";
      if (gulaSajian >= 10 && gulaSajian < 15) return "C";

      return "D";
    }
  }

  static String _getGaramScoreString(double garamSajian, bool hasHipertensi) {
    if (hasHipertensi) {
      if (garamSajian < 0.5) return "A";
      if (garamSajian >= 0.5 && garamSajian < 1) return "B";
      if (garamSajian >= 1 && garamSajian < 1.5) return "C";
      return "D";
    } else {
      if (garamSajian < 0.5) return "A";
      if (garamSajian >= 0.5 && garamSajian < 1.5) return "B";
      if (garamSajian >= 1.5 && garamSajian < 2) return "C";
      return "D";
    }
  }

  /// Examine nutrition status and return image with vibration and speech
  static Widget examineImage(double garam, double gula, double sajian,
      bool hasHipertensi, bool hasDiabetes,
      {bool enableVibrationAndSpeech = true}) {
    final double garamSajian = garam * sajian / 1000;
    final double gulaSajian = gula * sajian;
    print("gula: $gula garam: $garam sajian: $sajian");

    final String title =
        examineNutritionTitle(garam, gula, sajian, hasHipertensi, hasDiabetes);

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

  static String examineNutritionTitle(
    double garam,
    double gula,
    double sajian,
    bool hasHipertensi,
    bool hasDiabetes,
  ) {
    final double garamSajian = (garam * sajian) / 1000;
    final double gulaSajian = gula * sajian;
    final String skorGaram = _getGaramScoreString(garamSajian, hasHipertensi);
    final String skorGula = _getGulaScoreString(gulaSajian, 0, hasDiabetes);

    if (skorGula == "C" || skorGula == "D") {
      return "Kandungan Gula Tinggi";
    } else if (skorGula == "A" || skorGula == "B") {
      return "Produk Aman Dikonsumsi";
    } else if (skorGaram == "C" || skorGaram == "D") {
      return "Kandungan Garam Tinggi";
    } else {
      return "Produk Aman Dikonsumsi";
    }
  }

// Fungsi pembantu untuk menentukan prioritas skor (A = 1, B = 2, dst.)
  static int _scorePriority(String score) {
    switch (score) {
      case "A":
        return 1;
      case "B":
        return 2;
      case "C":
        return 3;
      case "D":
        return 4;
      default:
        return 0; // Untuk keamanan
    }
  }

  static String examineDescription(
      String title, double garam, double gula, double sajian) {
    final double garamSajian = (garam * sajian) / 1000; // mg ke gram
    final double gulaSajian = gula * sajian;

    // Skor deskriptif berdasarkan nilai
    if (title == "Kandungan Gula Tinggi") {
      return "$gulaSajian gram gula setara dengan kurang lebih ${(gulaSajian / 15).toStringAsFixed(1)} sdm. "
          "Mengonsumsi $gulaSajian gram gula pada produk ini sudah mencapai "
          "${((gulaSajian / gulaLimit) * 100).toInt()}% dari batas asupan gula harian yang direkomendasikan. "
          "Mengonsumsi gula berlebihan dapat meningkatkan risiko terkena diabetes.";
    } else if (title == "Kandungan Garam Tinggi") {
      return "$garamSajian mg garam setara dengan kurang lebih ${(garamSajian / 5).toStringAsFixed(1)} sdt. "
          "Mengonsumsi $garamSajian mg garam pada produk ini sudah mencapai "
          "${((garamSajian / garamLimit) * 100).toInt()}% dari batas asupan garam harian yang direkomendasikan. "
          "Mengonsumsi garam berlebihan dapat meningkatkan risiko hipertensi.";
    } else {
      return "Produk ini mengandung $garamSajian mg garam dan $gulaSajian gram gula. Produk ini aman, "
          "tetapi tetap disarankan menjaga pola makan seimbang.";
    }
  }

  static void _handleVibrationAndSpeech(
      String title, double garamSajian, double gulaSajian) {
    int gulaSdm = (gulaSajian / 15).ceil();
    int garamSdt = (garamSajian / 5).ceil();
    if (title == "Kandungan Garam Tinggi") {
      _vibrate(pattern: [500, 2000, 500]);
      _speak("$garamSajian mg garam setara dengan kurang lebih $garamSdt sdt. "
          "Mengonsumsi $garamSajian mg garam pada produk ini sudah mencapai "
          "${((garamSajian / 2) * 100).toInt()}% dari batas asupan garam harian yang direkomendasikan oleh Kementerian Kesehatan Republik Indonesia. "
          "Mengonsumsi garam berlebihan dapat meningkatkan risiko terkena hipertensi.");
    } else if (title == "Kandungan Gula Tinggi") {
      _vibrate(pattern: [500, 2000, 500]);
      _speak("$gulaSajian gram gula setara dengan kurang lebih $gulaSdm sdm. "
          "Mengonsumsi $gulaSajian gram gula pada produk ini sudah mencapai "
          "${((gulaSajian / 50) * 100).toInt()}% dari batas asupan gula harian yang direkomendasikan oleh Kementerian Kesehatan Republik Indonesia "
          "(50 gram untuk wanita, 65 gram untuk pria). Mengonsumsi gula berlebihan dapat meningkatkan risiko terkena diabetes.");
    }
  }

  static Future<void> _speak(String text) async {
    await _textToSpeech.setLanguage("id");
    await _textToSpeech.setPitch(1);
    await _textToSpeech.speak(text);
  }

  static void stopTTS() {
    _textToSpeech.stop();
    Vibration.cancel();
  }

  static void _vibrate({required List<int> pattern}) {
    Vibration.vibrate(pattern: pattern);
  }
}

double roundDouble(double value, double places) {
  double mod = pow(10.0, places).toDouble();
  return ((value * mod).round().toDouble() / mod);
}
/*
String examineDescription(
    String title, double garam, double gula, double sajian) {
  // Menghitung total garam dan gula per sajian
  var garamSajian = garam * sajian;
  var gulaSajian = gula * sajian;

  // Menghitung setara dalam satuan rumah tangga
  double persamaanGaram =
      roundDouble(garamSajian / 2000, 1); // Setara sendok teh
  double persamaanGula = roundDouble(gulaSajian / 15, 1); // Setara sendok makan

  if (title == "Kandungan Gula Tinggi") {
    return "$gulaSajian gram gula setara dengan kurang lebih $persamaanGula sdm. "
        "Mengonsumsi $gulaSajian gram gula pada produk ini sudah mencapai "
        "${((gulaSajian / 50) * 100).toInt()}% dari batas asupan gula harian yang direkomendasikan oleh Kementerian Kesehatan Republik Indonesia "
        "(50 gram untuk wanita, 65 gram untuk pria). Mengonsumsi gula berlebihan dapat meningkatkan risiko terkena diabetes.";
  } else if (title == "Kandungan Garam Tinggi") {
    return "$garamSajian mg garam setara dengan kurang lebih $persamaanGaram sdt. "
        "Mengonsumsi $garamSajian mg garam pada produk ini sudah mencapai "
        "${((garamSajian / 2000) * 100).toInt()}% dari batas asupan garam harian yang direkomendasikan oleh Kementerian Kesehatan Republik Indonesia. "
        "Mengonsumsi garam berlebihan dapat meningkatkan risiko terkena hipertensi.";
  } else {
    return "Produk ini mengandung $garamSajian mg garam dan $gulaSajian gr gula, yang tergolong cukup aman dikonsumsi. "
        "Namun, tetap jaga asupan gula dan garam dari sumber lain untuk mengurangi risiko terkena penyakit tidak menular seperti diabetes dan hipertensi.";
  }
}
*/
