import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'app_colors.dart';

class AppDropdown extends StatefulWidget {
  final List<DropdownMenuItem>? items;
  final String title;
  final String hint;
  final Color textHintColor;
  final String? errorText;
  final Function(String) onSelected;
  final void Function(dynamic) onChanged;
  final dynamic value;
  final IconData? startIcon; // Tambahkan ini
  const AppDropdown({
    Key? key,
    required this.title,
    required this.hint,
    required this.textHintColor,
    this.errorText,
    required this.onSelected,
    this.items,
    this.value,
    required this.onChanged,
    this.startIcon, // Tambahkan ini
  }) : super(key: key);

  @override
  State<AppDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  bool focused = false;
  bool alreadyClicked = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.title.isNotEmpty
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
            child: SizedBox(
              height: 71,
              child: DropdownButtonFormField2(
                isDense: false,
                value: widget.value,
                isExpanded: true,
                alignment: AlignmentDirectional.centerStart,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  hintText: widget.hint,
                  hintStyle: context.textTheme.bodyLarge?.copyWith(
                    color: AppColors.textGray,
                  ),
                  filled: true,
                  fillColor: AppColors.grayBG,
                  errorText: alreadyClicked ? widget.errorText : null,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 12,
                  ),
                  prefixIcon: widget.startIcon != null
                      ? Icon(
                          widget.startIcon,
                          color: AppColors.textGray,
                        )
                      : null,
                ),
                hint: Text(
                  widget.hint,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.textGray.withOpacity(0.8),
                  ),
                ),
                items: widget.items,
                validator: (value) {
                  if (value == null) {
                    return 'Please select category';
                  }
                  return null;
                },
                onChanged: widget.onChanged,
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.only(right: 8),
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 24,
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppColors.grayBG,
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
