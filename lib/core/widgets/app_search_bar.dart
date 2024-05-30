import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';

import 'app_colors.dart';

class AppSearchBar extends StatefulWidget {
  const AppSearchBar({
    Key? key,
    required this.hint,
    this.onClick,
    this.withElevation,
    this.readOnly = false,
    this.onChanged,
  }) : super(key: key);
  final String hint;
  final Function? onClick;
  final bool? withElevation;
  final bool readOnly;
  final Function(String)? onChanged;

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  final controller = TextEditingController();
  bool? showClearButton;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onClick?.call(),
      child: Material(
        color: Colors.white,
        elevation: widget.withElevation == true ? 1 : 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: const BorderSide(
            color: AppColors.textGray,
          ),
        ),
        child: TextField(
          cursorColor: AppColors.primary,
          enabled: widget.onClick == null,
          style: context.textTheme.bodyLarge?.copyWith(
            color: AppColors.textBlack,
          ),
          readOnly: widget.readOnly,
          onChanged: (data) {
            widget.onChanged?.call(data);
            setState(() {
              showClearButton = controller.text.isNotEmpty;
            });
          },
          controller: controller,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: context.textTheme.bodyLarge?.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AppColors.textGray,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(
                color: AppColors.grayBG,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(
                color: AppColors.textBlack,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),
            suffixIcon: showClearButton == true
                ? GestureDetector(
                    onTap: () {
                      controller.text = '';
                      widget.onChanged?.call('');
                      setState(() {
                        showClearButton = false;
                      });
                    },
                    child: const Icon(
                      Ionicons.close,
                      color: AppColors.secondary,
                    ),
                  )
                : const Icon(
                    Ionicons.search_circle,
                    color: AppColors.primary,
                    size: 40,
                  ),
          ),
        ),
      ),
    );
  }
}
