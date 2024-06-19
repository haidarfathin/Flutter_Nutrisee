import 'package:flutter/material.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';

class GaugeBmi extends StatelessWidget {
  final double bmiValue;
  const GaugeBmi({super.key, required this.bmiValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 35,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                    ),
                    color: Colors.blue.shade200,
                    border: bmiValue < 18.5
                        ? Border.all(
                            color: Colors.blue.shade500,
                            width: 5,
                          )
                        : null,
                  ),
                  child: Text(
                    "< 18.5",
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.green.shade300,
                    border: (18.5 <= bmiValue && bmiValue <= 24.9)
                        ? Border.all(
                            color: Colors.green.shade500,
                            width: 5,
                          )
                        : null,
                  ),
                  child: Text(
                    "18.5 - 24.9",
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade200,
                    border: (25.0 <= bmiValue && bmiValue <= 29.9)
                        ? Border.all(
                            color: Colors.yellow,
                            width: 5,
                          )
                        : null,
                  ),
                  child: Text(
                    "25.0 - 29.9",
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    color: Colors.red.shade300,
                    border: bmiValue >= 30.0
                        ? Border.all(
                            color: Colors.red.shade500,
                            width: 5,
                          )
                        : null,
                  ),
                  child: Text(
                    "> 30.0",
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.arrow_drop_up_rounded,
                size: 30,
                color:
                    bmiValue < 18.5 ? Colors.blue.shade500 : Colors.transparent,
              ),
              Icon(
                Icons.arrow_drop_up_rounded,
                size: 30,
                color: (18.5 <= bmiValue && bmiValue <= 24.9)
                    ? Colors.green.shade500
                    : Colors.transparent,
              ),
              Icon(
                Icons.arrow_drop_up_rounded,
                size: 30,
                color: (25.0 <= bmiValue && bmiValue <= 29.9)
                    ? Colors.yellow
                    : Colors.transparent,
              ),
              Icon(
                Icons.arrow_drop_up_rounded,
                size: 30,
                color:
                    bmiValue >= 25 ? Colors.red.shade500 : Colors.transparent,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
