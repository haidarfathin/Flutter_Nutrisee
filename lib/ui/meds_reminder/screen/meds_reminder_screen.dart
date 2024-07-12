import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:nutrisee/core/data/model/firestore/reminder_data.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/ui/meds_reminder/screen/add_reminder_screen.dart';

import '../widget/list_date.dart';

class MedsReminderScreen extends StatefulWidget {
  const MedsReminderScreen({super.key});

  @override
  State<MedsReminderScreen> createState() => _MedsReminderScreenState();
}

class _MedsReminderScreenState extends State<MedsReminderScreen> {
  final List<ReminderData> listData = [
    ReminderData(
      name: "Paramex",
      date: DateTime.now(),
      medTotal: 2,
      selectedTime: [
        TimeOfDay(hour: 7, minute: 0),
      ],
      medType: "Kapsul",
      timeToDrink: "Sesudah",
    ),
    ReminderData(
      name: "Bodrex",
      date: DateTime.now(),
      medTotal: 1,
      selectedTime: [
        TimeOfDay(hour: 7, minute: 0),
        TimeOfDay(hour: 12, minute: 0),
      ],
      medType: "Tablet",
      timeToDrink: "Sesudah",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBG,
      appBar: AppBar(
        title: Text("Pengingat Obat"),
        centerTitle: true,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddReminderScreen()));
        },
        backgroundColor: AppColors.primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            sliver: SliverToBoxAdapter(
              child: ListDate(
                dateSelected: (date) {},
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    border: const GradientBoxBorder(
                      width: 3,
                      gradient: AppColors.greenGradient,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        listData[index].name,
                        style: context.textTheme.titleLarge,
                      ),
                      const Gap(14),
                      Text(
                        listData[index].timeToDrink,
                        style: context.textTheme.bodyLarge,
                      ),
                      const Gap(8),
                      SizedBox(
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: listData[index].selectedTime.length,
                          itemBuilder: (context, innerIndex) {
                            var time = listData[index].selectedTime[innerIndex];
                            return Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.orange.shade300,
                              ),
                              margin: const EdgeInsets.only(right: 8),
                              child: Text(
                                time.format(context),
                                style: context.textTheme.titleMedium?.copyWith(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: listData.length,
            ),
          ),
        ],
      ),
    );
  }
}
