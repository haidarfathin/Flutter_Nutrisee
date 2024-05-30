import 'package:flutter/material.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'app_colors.dart';

class AppTextField extends StatefulWidget {
  final String hint;
  final String title;
  final bool obscure;
  final Color textHintColor;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? errorText;
  final endIcon;
  final IconData? startIcon;
  final Function? endIconClicked;
  final bool? readOnlyField;
  final Function()? onTap;
  final TextInputType? keyboardType;
  const AppTextField({
    Key? key,
    required this.hint,
    this.title = '',
    this.obscure = false,
    this.textHintColor = Colors.white,
    this.controller,
    this.onChanged,
    this.errorText,
    this.endIcon,
    this.onTap,
    this.startIcon,
    this.endIconClicked,
    this.readOnlyField,
    this.keyboardType,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool isVisible = false;
  bool focused = false;
  bool alreadyClicked = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.title != ''
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.title,
                      style: context.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: widget.errorText != null && alreadyClicked
                            ? AppColors.error
                            : focused
                                ? AppColors.primary
                                : AppColors.textBlack,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                )
              : Container(),
          FocusScope(
            onFocusChange: (focus) {
              setState(() {
                focused = focus;
                alreadyClicked = true;
              });
            },
            child: TextField(
              obscureText: widget.obscure && isVisible == false,
              controller: widget.controller,
              onChanged: widget.onChanged,
              readOnly: widget.readOnlyField == true,
              onTap: widget.onTap,
              keyboardType: widget.keyboardType,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(14)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(14)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(14)),
                hintText: widget.hint,
                hintStyle: context.textTheme.bodyLarge?.copyWith(
                  color: AppColors.textGray,
                ),
                filled: true,
                fillColor: AppColors.grayBG,
                errorText: alreadyClicked ? widget.errorText : null,
                prefixIcon: widget.startIcon != null
                    ? Icon(
                        widget.startIcon,
                        color: AppColors.textGray,
                      )
                    : null,
                suffixIcon: widget.obscure
                    ? InkWell(
                        onTap: () => setState(() => isVisible = !isVisible),
                        child: Icon(isVisible
                            ? Icons.visibility_off
                            : Icons.visibility),
                      )
                    : widget.endIcon != null
                        ? InkWell(
                            child: (widget.endIcon is IconData)
                                ? Icon(widget.endIcon as IconData,
                                    color: AppColors.textGray)
                                : Container(
                                    width: 50,
                                    alignment: Alignment.center,
                                    child: widget.endIcon,
                                  ),
                            onTap: () => widget.endIconClicked?.call(),
                          )
                        : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
