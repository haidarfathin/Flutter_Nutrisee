import 'package:flutter/material.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';

class MedicalCard extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? foregroundColor;
  const MedicalCard(
      {super.key,
      required this.text,
      this.backgroundColor,
      this.foregroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: backgroundColor ?? Colors.grey.shade300),
      child: Text(
        text,
        style: context.textTheme.titleSmall?.copyWith(
          color: foregroundColor ?? Colors.black.withOpacity(0.8),
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
