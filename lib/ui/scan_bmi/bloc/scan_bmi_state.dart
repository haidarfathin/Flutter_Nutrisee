part of 'scan_bmi_bloc.dart';

abstract class ScanBmiState extends Equatable {
  const ScanBmiState();

  @override
  List<Object> get props => [];
}

class ScanBmiInitial extends ScanBmiState {}

class AnalyzeBmiLoading extends ScanBmiState {}

class AnalyzeBmiSuccess extends ScanBmiState {
  final String analysis;
  const AnalyzeBmiSuccess(this.analysis);

  @override
  List<Object> get props => [analysis];
}

class AnalyzeBmiError extends ScanBmiState {
  final String message;

  const AnalyzeBmiError(this.message);

  @override
  List<Object> get props => [message];
}
