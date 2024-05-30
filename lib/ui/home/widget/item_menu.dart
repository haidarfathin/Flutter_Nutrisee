import "package:flutter/material.dart";
import "package:gap/gap.dart";
import "package:nutrisee/core/utils/theme_extension.dart";
import "package:nutrisee/core/widgets/app_colors.dart";
import "package:nutrisee/ui/router.dart";

class MenuItem extends StatelessWidget {
  final Widget icon;
  final String title;
  final String route;

  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => router.push(route),
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(2, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 70,
              height: 70,
              child: icon,
            ),
            const Gap(4),
            Text(
              title,
              style: context.textTheme.labelSmall?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
