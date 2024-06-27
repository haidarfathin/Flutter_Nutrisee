class UserData {
  final String uid;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final int height;
  final int weight;
  final DateTime birthDate;
  final bool hasDiabetes;
  final String? diabetesType;

  UserData({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.height,
    required this.weight,
    required this.birthDate,
    required this.hasDiabetes,
    this.diabetesType,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'height': height,
      'weight': weight,
      'birthDate': birthDate.toIso8601String(),
      'hasDiabetes': hasDiabetes,
      'diabetesType': diabetesType,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      uid: map["uid"],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      gender: map['gender'],
      height: map['height'],
      weight: map['weight'],
      birthDate: DateTime.parse(map['birthDate']),
      hasDiabetes: map['hasDiabetes'],
      diabetesType: map['diabetesType'],
    );
  }
}
