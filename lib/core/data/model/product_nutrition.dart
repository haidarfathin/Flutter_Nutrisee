import 'dart:convert';
import 'package:collection/collection.dart';

class ProductNutrition {
  num? sugar;
  num? saturatedFat;
  num? natrium;
  num? sajianPerKemasan;
  num? takaranSaji;

  bool? isNutritionFacts;

  ProductNutrition({
    this.sugar,
    this.saturatedFat,
    this.natrium,
    this.sajianPerKemasan,
    this.takaranSaji,
    this.isNutritionFacts,
  });

  @override
  String toString() {
    return 'ProductNutrition(sugar: $sugar, saturatedFat: $saturatedFat, natrium: $natrium, sajianPerKemasan: $sajianPerKemasan, takaranSaji: $takaranSaji,)';
  }

  // Factory constructor to create a ProductNutrition object from a Map
  factory ProductNutrition.fromMap(Map<String, dynamic> data) {
    num? sugar = data['gula'] as num?;
    num? saturatedFat = data['lemak_jenuh'] as num?;
    num? natrium = data['garam'] as num?;
    num? takaranSaji = data['takaran_saji'] as num?;
    num? sajianPerKemasan = data['sajian_per_kemasan'] as num?;
    bool isNutritionFacts =
        (takaranSaji == 0 && sajianPerKemasan == 0) ? false : true;

    return ProductNutrition(
      sugar: sugar,
      saturatedFat: saturatedFat,
      natrium: natrium,
      sajianPerKemasan: sajianPerKemasan,
      takaranSaji: takaranSaji,
      isNutritionFacts: isNutritionFacts,
    );
  }

  // Method to convert a ProductNutrition object to a Map
  Map<String, dynamic> toMap() => {
        'sugar': sugar,
        'saturated_fat': saturatedFat,
        'natrium': natrium,
        'sajian_per_kemasan': sajianPerKemasan,
        'takaran_saji': takaranSaji,
        'isNutritionFacts': isNutritionFacts
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ProductNutrition].
  factory ProductNutrition.fromJson(String data) {
    return ProductNutrition.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ProductNutrition] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ProductNutrition) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      sugar.hashCode ^
      saturatedFat.hashCode ^
      natrium.hashCode ^
      sajianPerKemasan.hashCode ^
      takaranSaji.hashCode ^
      isNutritionFacts.hashCode;
}
