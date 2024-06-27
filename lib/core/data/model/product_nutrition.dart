import 'dart:convert';
import 'package:collection/collection.dart';

class ProductNutrition {
  int? sugar;
  int? saturatedFat;
  int? natrium;
  int? sajianPerKemasan;
  num? takaranSaji;
  String? description;

  ProductNutrition({
    this.sugar,
    this.saturatedFat,
    this.natrium,
    this.sajianPerKemasan,
    this.takaranSaji,
    this.description,
  });

  @override
  String toString() {
    return 'ProductNutrition(sugar: $sugar, saturatedFat: $saturatedFat, natrium: $natrium, sajianPerKemasan: $sajianPerKemasan, takaranSaji: $takaranSaji, description: $description)';
  }

  // Factory constructor to create a ProductNutrition object from a Map
  factory ProductNutrition.fromMap(Map<String, dynamic> data) {
    return ProductNutrition(
      sugar: data['gula'] as int?,
      saturatedFat: data['lemak_jenuh'] as int?,
      natrium: data['garam'] as int?,
      sajianPerKemasan: data['sajian_per_kemasan'] as int?,
      takaranSaji: data['takaran_saji'] as num?,
      description: data['description'] as String?,
    );
  }

  // Method to convert a ProductNutrition object to a Map
  Map<String, dynamic> toMap() => {
        'sugar': sugar,
        'saturated_fat': saturatedFat,
        'natrium': natrium,
        'sajian_per_kemasan': sajianPerKemasan,
        'takaran_saji': takaranSaji,
        'description': description,
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
      description.hashCode;
}
