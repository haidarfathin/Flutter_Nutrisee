import 'package:flutter/material.dart';

class LinearRange extends StatelessWidget {
  final List<RangeSection> sections;
  final int markerPosition; // value between 0 and 20

  const LinearRange({
    Key? key,
    required this.sections,
    required this.markerPosition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double totalWidth = constraints.maxWidth;
        final double sectionWidth = totalWidth / 26;

        return Stack(
          alignment: Alignment.centerLeft,
          children: [
            Row(
              children: List.generate(sections.length, (index) {
                return Expanded(
                  flex: sections[index].flex,
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: sections[index].color,
                      borderRadius: BorderRadius.horizontal(
                        left: index == 0 ? Radius.circular(20) : Radius.zero,
                        right: index == sections.length - 1
                            ? Radius.circular(20)
                            : Radius.zero,
                      ),
                    ),
                  ),
                );
              }),
            ),
            Positioned(
              left: (markerPosition / 26) * totalWidth - 10,
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 7,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class RangeSection {
  final Color color;
  final int flex;

  RangeSection({
    required this.color,
    required this.flex,
  });
}
