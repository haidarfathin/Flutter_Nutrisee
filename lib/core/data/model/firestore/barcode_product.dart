class BarcodeProduct {
  final int barcode;
  final String name;
  final num natrium;
  final num sugar;
  final num saturatedFat;
  final num takaranSaji;
  final num sajian;

  BarcodeProduct({
    required this.barcode,
    required this.name,
    required this.natrium,
    required this.sugar,
    required this.saturatedFat,
    required this.takaranSaji,
    required this.sajian,
  });

  Map<String, dynamic> toMap() {
    return {
      'barcode': barcode,
      'name': name,
      'natrium': natrium,
      'sugar': sugar,
      'saturatedFat': saturatedFat,
      'sajian': sajian,
      'takaranSaji': takaranSaji,
    };
  }

  factory BarcodeProduct.fromMap(Map<String, dynamic> map) {
    return BarcodeProduct(
      barcode: map['barcode'],
      name: map['name'],
      natrium: map['natrium'],
      sugar: map['sugar'],
      saturatedFat: map['saturated_fat'],
      takaranSaji: map['takaran_saji'],
      sajian: map['sajian'],
    );
  }
}
