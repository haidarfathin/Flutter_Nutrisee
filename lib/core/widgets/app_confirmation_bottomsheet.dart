import 'package:flutter/material.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/utils/translation.dart';
import 'package:nutrisee/core/widgets/app_theme.dart';

import 'app_button.dart';
import 'app_colors.dart';

class AppConfirmationBottomSheet extends StatelessWidget {
  const AppConfirmationBottomSheet({
    Key? key,
    required this.onConfirm,
    required this.image,
    required this.title,
    required this.content,
    required this.btnConfirmText,
    this.height = 44,
    this.cancelText,
    this.onCancel,
  }) : super(key: key);
  final Function onConfirm;
  final Image image;
  final String title;
  final String content;
  final String btnConfirmText;
  final double height;
  final String? cancelText;
  final Function? onCancel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: AppTheme.marginVertical,
        horizontal: AppTheme.marginHorizontal,
      ),
      child: Column(
        children: [
          image,
          const SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: context.textTheme.titleLarge,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            content,
            style: context.textTheme.bodyLarge?.copyWith(
              color: AppColors.textGray,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Flexible(
                flex: 1,
                child: AppButton(
                  onPressed: () =>
                      onCancel?.call() ?? Navigator.of(context).pop(),
                  isEnabled: true,
                  caption: cancelText ?? context.text.cancel,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Flexible(
                flex: 1,
                child: AppButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onConfirm();
                  },
                  isEnabled: true,
                  caption: btnConfirmText,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
