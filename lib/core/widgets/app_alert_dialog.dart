import 'package:flutter/material.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_button.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';

extension ShowCustomDialog on BuildContext {
  Future<dynamic> showCustomDialog({
    required Widget content,
    Color bgColor = Colors.white,
  }) {
    return showDialog(
      context: this,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 50,
          ),
          child: Dialog(
            backgroundColor: bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: content,
          ),
        );
      },
    );
  }
}

Widget loadingContentDialog({
  required BuildContext context,
  String message = "Memuat",
}) {
  return Container(
    margin: const EdgeInsets.all(20),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 24),
        const CircularProgressIndicator(),
        const SizedBox(height: 16),
        Text(message),
        const SizedBox(height: 24),
      ],
    ),
  );
}

Widget alertContentDialog({
  required BuildContext context,
  ImageProvider? image,
  required String title,
  required String subtitle,
  required Function() onConfirm,
  required Function() onCancel,
  bool isLoading = false,
}) {
  return Container(
    margin: const EdgeInsets.all(20),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        image != null
            ? Container(
                margin: const EdgeInsets.only(bottom: 15),
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: image,
                  ),
                ),
              )
            : Container(),
        Text(
          title,
          style: context.textTheme.bodyLarge?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: AppColors.textBlack,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          subtitle,
          style: context.textTheme.bodyMedium?.copyWith(
            color: AppColors.textGray,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            Expanded(
              child: AppButton(
                onPressed: onCancel,
                caption: "TIDAK",
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AppButton(
                onPressed: onConfirm,
                color: AppColors.primary,
                caption: "YA",
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Widget infoContentDialog({
  required ImageProvider image,
  required BuildContext context,
  required String title,
  required Function() onConfirm,
}) {
  return Container(
    margin: const EdgeInsets.all(20),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 15),
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: image,
            ),
          ),
        ),
        Text(
          title,
          style: context.textTheme.bodyLarge?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textBlack,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
        AppButton(
          onPressed: onConfirm,
          color: AppColors.primary,
          caption: "OK",
        ),
      ],
    ),
  );
}
