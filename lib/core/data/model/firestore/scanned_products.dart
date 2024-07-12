class ScannedProduct {
  final String image;
  final bool isSugarHighest;
  final String name;
  final String score;
  final num natrium;
  final num sugar;
  final num fat;

  ScannedProduct({
    required this.image,
    required this.isSugarHighest,
    required this.name,
    required this.score,
    required this.natrium,
    required this.sugar,
    required this.fat,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'isSugarHighest': isSugarHighest,
      'name': name,
      'score': score,
      'natrium': natrium,
      'sugar': sugar,
      'fat': fat,
    };
  }

  factory ScannedProduct.fromMap(Map<String, dynamic> map) {
    return ScannedProduct(
      image: map['image'],
      isSugarHighest: map['isSugarHighest'],
      name: map['name'],
      score: map['score'],
      natrium: map['natrium'],
      sugar: map['sugar'],
      fat: map['fat'],
    );
  }
}
