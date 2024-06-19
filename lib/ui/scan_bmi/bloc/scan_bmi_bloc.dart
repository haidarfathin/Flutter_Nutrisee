import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:nutrisee/core/data/prompt.dart';

part 'scan_bmi_event.dart';
part 'scan_bmi_state.dart';

class ScanBmiBloc extends Bloc<ScanBmiEvent, ScanBmiState> {
  final Gemini gemini;
  ScanBmiBloc(this.gemini) : super(ScanBmiInitial()) {
    on<AnalyzeBmi>(_onAnalyzeBmi);
  }

  Future<void> _onAnalyzeBmi(
      AnalyzeBmi event, Emitter<ScanBmiState> emit) async {
    emit(AnalyzeBmiLoading());

    try {
      final result = await gemini.text(
        Prompt.describeBmiPrompt
            .replaceFirst('[bmi_value]', event.bmiValue.toString())
            .replaceFirst(
              '[category]',
              event.category,
            ),
      );

      final analysis =
          result?.content?.parts?.last.text ?? 'No analysis available';
      emit(AnalyzeBmiSuccess(analysis));
    } catch (e) {
      emit(const AnalyzeBmiError('Error analyzing BMI'));
    }
  }
}
