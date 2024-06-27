import 'package:equatable/equatable.dart';

class TaskDay extends Equatable {
  DateTime? date;
  bool? selected;

  TaskDay({this.date, this.selected});

  @override
  List<Object?> get props => [date, selected];
}
