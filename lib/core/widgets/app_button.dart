import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';

import 'app_colors.dart';

class AppButton extends StatelessWidget {
  final Color color;
  final Function onPressed;
  final bool useIcon;
  final String caption;
  final bool isEnabled;
  final bool isLoading;
  final BoxBorder? border;
  final TextStyle? captionStyle;

  const AppButton({
    super.key,
    this.color = AppColors.primary,
    this.caption = 'Button',
    this.useIcon = true,
    this.border,
    this.captionStyle,
    required this.onPressed,
    this.isEnabled = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: isEnabled == true || isLoading == false ? () => onPressed() : null,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(50),
              border: border,
            ),
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.whiteBG,
                    ),
                  )
                : Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Center(
                        child: Text(caption,
                            style: captionStyle ??
                                context.textTheme.bodyLarge?.copyWith(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                )),
                      ),
                      useIcon
                          ? Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.greenSwatch.shade300,
                              ),
                              child: const Center(
                                child: Icon(
                                  Ionicons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
