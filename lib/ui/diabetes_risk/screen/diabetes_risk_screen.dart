import 'package:flutter/material.dart';

class DiabetesRiskScreen extends StatelessWidget {
  const DiabetesRiskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("Risiko Diabetes"),
          )
        ],
      ),
    );
  }
}
