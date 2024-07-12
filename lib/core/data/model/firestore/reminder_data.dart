import 'package:flutter/material.dart';

class ReminderData {
  final String name;
  final DateTime date;
  final int medTotal;
  final List<TimeOfDay> selectedTime;
  final String medType;
  final String timeToDrink;

  ReminderData({
    required this.name,
    required this.date,
    required this.medTotal,
    required this.selectedTime,
    required this.medType,
    required this.timeToDrink,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date.toIso8601String(), // Convert DateTime to string for storage
      'medTotal': medTotal,
      'selectedTime': selectedTime
          .map((time) => "${time.hour}:${time.minute}")
          .toList(), // Convert TimeOfDay to string
      'medType': medType,
      'timeToDrink': timeToDrink,
    };
  }

  factory ReminderData.fromMap(Map<String, dynamic> map) {
    return ReminderData(
      name: map['name'],
      date: DateTime.parse(map['date']), // Convert string back to DateTime
      medTotal: map['medTotal'],
      selectedTime: (map['selectedTime'] as List<dynamic>).map((time) {
        List<String> parts = time.split(":");
        return TimeOfDay(
            hour: int.parse(parts[0]), minute: int.parse(parts[1]));
      }).toList(),
      medType: map['medType'],
      timeToDrink: map['timeToDrink'],
    );
  }
}
