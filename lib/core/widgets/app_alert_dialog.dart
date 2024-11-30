import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
      width: 80,
      height: 80,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.green.shade100,
      ),
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      ));
}

// Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         const SizedBox(height: 24),
//         const CircularProgressIndicator(
//           color: AppColors.primary,
//         ),
//         const SizedBox(height: 16),
//         Text(message),
//         const SizedBox(height: 24),
//       ],
//     ),

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

Widget sizeContentDialog({
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
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.red,
                    width: 1.5,
                  )),
              child: const Icon(
                Icons.close,
                color: Colors.red,
              ),
            ),
          ),
        ),
        const Gap(10),
        Text(
          title,
          style: context.textTheme.bodySmall?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
          textAlign: TextAlign.center,
        ),
        const Gap(20),
        SizedBox(
          height: 300,
          child: Table(
            border: TableBorder.all(color: Colors.grey), // Add borders
            columnWidths: const {
              0: FlexColumnWidth(2), // Adjust column width
              1: FlexColumnWidth(1),
            },
            children: [
              // Header Row
              TableRow(
                decoration: BoxDecoration(color: Colors.grey[300]),
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Lingkar\nPinggang (cm)',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Ukuran Celana',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              // Data Rows
              const TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('< 80', textAlign: TextAlign.center),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('< 30', textAlign: TextAlign.center),
                  ),
                ],
              ),
              const TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('80-88', textAlign: TextAlign.center),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('31-34', textAlign: TextAlign.center),
                  ),
                ],
              ),
              const TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('89-93', textAlign: TextAlign.center),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('35-36', textAlign: TextAlign.center),
                  ),
                ],
              ),
              const TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('94-102', textAlign: TextAlign.center),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('37-40', textAlign: TextAlign.center),
                  ),
                ],
              ),
              const TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('> 102', textAlign: TextAlign.center),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('> 40', textAlign: TextAlign.center),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
