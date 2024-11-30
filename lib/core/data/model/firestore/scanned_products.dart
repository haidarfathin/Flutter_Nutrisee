import 'package:cloud_firestore/cloud_firestore.dart';

class ScannedProduct {
  final String image;
  final bool isSugarHighest;
  final String name;
  final String score;
  final num salt;
  final double totalSalt;
  final num sugar;
  final double totalSugar;
  final num fat;
  final DateTime timeStamp;

  ScannedProduct({
    required this.image,
    required this.isSugarHighest,
    required this.name,
    required this.score,
    required this.salt,
    required this.sugar,
    required this.totalSugar,
    required this.totalSalt,
    required this.fat,
    required this.timeStamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'isSugarHighest': isSugarHighest,
      'name': name,
      'score': score,
      'salt': salt,
      'sugar': sugar,
      'fat': fat,
      'timeStamp': timeStamp,
      'totalSugar': totalSugar,
      'totalSalt': totalSalt,
    };
  }

  factory ScannedProduct.fromMap(Map<String, dynamic> map) {
    return ScannedProduct(
      image: map['image'],
      isSugarHighest: map['isSugarHighest'],
      name: map['name'],
      score: map['score'],
      salt: map['salt'],
      sugar: map['sugar'],
      fat: map['fat'],
      timeStamp: (map['timeStamp'] as Timestamp).toDate(),
      totalSugar: map['totalSugar'],
      totalSalt: map['totalSalt'],
    );
  }
}
