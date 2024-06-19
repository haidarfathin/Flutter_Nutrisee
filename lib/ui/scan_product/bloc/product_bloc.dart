import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:nutrisee/core/data/model/product_nutrition.dart';
import 'package:nutrisee/core/data/prompt.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final Gemini gemini;

  ProductBloc(this.gemini) : super(ProductInitial()) {
    on<AnalyzeProduct>(_onAnalyzeProduct);
  }

  Future<void> _onAnalyzeProduct(
      AnalyzeProduct event, Emitter<ProductState> emit) async {
    emit(AnalyzeProductLoading());
    try {
      final file = File(event.imagePath);
      final bytes = file.readAsBytesSync();

      final result = await gemini.textAndImage(
        text: Prompt.jsonProductPrompt,
        images: [bytes],
      );

      log('Result: ${result?.content?.parts?.last.text}');

      final rawText = result?.content?.parts?.last.text ?? '{}';
      final response = json.decode(rawText);
      final productNutrition = ProductNutrition.fromMap(response);
      log(productNutrition.toString());
      emit(AnalyzeProductSuccess(productNutrition));
    } catch (e) {
      log(e.toString());
      emit(AnalyzeProductError("Gagal mengekstrak nutrisi dari gambar: $e"));
    }
  }
}
