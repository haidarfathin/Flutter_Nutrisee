import 'package:flutter/material.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';

extension ShowSnackbar on BuildContext {
  void showSnackbar(String message, {bool isPositive = false}) {
    ScaffoldMessenger.maybeOf(this)?.showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 4,
          ),
          child: ListTile(
            leading: const Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
            tileColor: isPositive == true ? Colors.green : Colors.red,
            title: Text(
              message,
              style: textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
