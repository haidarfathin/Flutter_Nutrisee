part of 'scan_bmi_bloc.dart';

abstract class ScanBmiEvent extends Equatable {
  const ScanBmiEvent();

  @override
  List<Object> get props => [];
}

class AnalyzeBmi extends ScanBmiEvent {
  final double bmiValue;
  final String category;

  const AnalyzeBmi(this.bmiValue, this.category);

  @override
  List<Object> get props => [bmiValue, category];
}
