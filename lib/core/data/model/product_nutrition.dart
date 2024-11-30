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

  factory ProductNutrition.fromMap(Map<String, dynamic> data) {
    return ProductNutrition(
      sugar:
          (data['gula'] as num?)?.toDouble() ?? 0.0, // Nilai default jika null
      saturatedFat: (data['lemak_jenuh'] as num?)?.toDouble() ?? 0.0,
      natrium: (data['garam'] as num?)?.toDouble() ?? 0.0,
      takaranSaji: (data['takaran_saji'] as num?)?.toDouble() ?? 1.0,
      sajianPerKemasan: (data['sajian_per_kemasan'] as num?)?.toDouble() ?? 1.0,
      isNutritionFacts: data['isNutritionFacts'] == true,
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
