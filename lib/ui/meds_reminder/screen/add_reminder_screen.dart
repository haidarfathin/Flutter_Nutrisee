import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_button.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/core/widgets/app_dropdown.dart';
import 'package:nutrisee/core/widgets/app_textfield.dart';

class AddReminderScreen extends StatefulWidget {
  const AddReminderScreen({super.key});

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  int timePerday = 1;
  final List<String> timeList = ["07:00", "12:00", "16:00", "21:00"];
  List<DateTime> selectedTimes = [];
  String medTypeValue = "";
  String timeToDrink = "";
  int totalMeds = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBG,
      appBar: AppBar(
        title: const Text("Tambah Pengingat"),
        centerTitle: true,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    AppTextField(
                      hint: "Masukkan Nama Obat",
                      title: "Nama Obat",
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Some Text";
                        }
                        return null;
                      },
                    ),
                    const Gap(20),
                    AppTextField(
                      title: "Tanggal lahir",
                      hint: "dd-mm-YYYY",
                      startIcon: Ionicons.calendar_outline,
                      endIcon: Ionicons.chevron_forward,
                      readOnlyField: true,
                      controller: dateController,
                      onTap: () => _selectDate(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field ini harus diisi';
                        }
                        return null;
                      },
                    ),
                    const Gap(20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Berapa kali sehari?",
                        style: context.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    timeCrement(),
                    buildTimeChips(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Jumlah Obat",
                        style: context.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        totalCrement(),
                        const Gap(20),
                        Expanded(
                          child: SizedBox(
                            child: AppDropdown(
                              title: "",
                              hint: "Pilih Bentuk Obat",
                              items: const [
                                DropdownMenuItem(
                                    value: "kapsul", child: Text("Kapsul")),
                                DropdownMenuItem(
                                    value: "tablet", child: Text("Tablet")),
                                DropdownMenuItem(
                                    value: "sirup", child: Text("Sirup")),
                              ],
                              textHintColor: Colors.grey,
                              onSelected: (value) {
                                setState(() {
                                  medTypeValue = value;
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  timeToDrink = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(20),
                    AppDropdown(
                      title: "Waktu Minum",
                      hint: "Pilih Waktu minum obat",
                      items: const [
                        DropdownMenuItem(
                            value: "sebelum", child: Text("Sebelum Makan")),
                        DropdownMenuItem(
                            value: "saat", child: Text("Saat Makan")),
                        DropdownMenuItem(
                            value: "setelah", child: Text("Setelah Makan")),
                      ],
                      textHintColor: Colors.grey,
                      onSelected: (value) {
                        setState(() {
                          timeToDrink = value;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          timeToDrink = value;
                        });
                        log(timeToDrink);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AppButton(
                    onPressed: () {
                      //save data
                    },
                    caption: "Buat Pengingat",
                    useIcon: false,
                  ),
                ),
                const Gap(20),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget timeCrement() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              if (timePerday > 1) {
                timePerday--;
                selectedTimes.removeLast();
              }
            });
          },
          icon: const Icon(
            Icons.remove_circle_outline,
            size: 30,
            color: AppColors.secondary,
          ),
        ),
        Text(
          '$timePerday',
          style: context.textTheme.titleLarge,
        ),
        IconButton(
          onPressed: () {
            setState(() {
              if (timePerday < timeList.length) {
                timePerday++;
                selectedTimes.add(DateTime.parse(timeList[timePerday]));
                log(selectedTimes.toString());
              }
            });
          },
          icon: const Icon(
            Icons.add_circle_outline,
            size: 30,
            color: AppColors.secondary,
          ),
        ),
      ],
    );
  }

  Widget totalCrement() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              if (totalMeds > 1) {
                totalMeds--;
              }
            });
          },
          icon: const Icon(
            Icons.remove_circle_outline,
            size: 30,
            color: AppColors.primary,
          ),
        ),
        Text(
          '$totalMeds',
          style: context.textTheme.titleLarge,
        ),
        IconButton(
          onPressed: () {
            setState(() {
              if (totalMeds < timeList.length) {
                totalMeds++;
              }
            });
          },
          icon: const Icon(
            Icons.add_circle_outline,
            size: 30,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget buildTimeChips() {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 20),
      width: double.infinity,
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: timePerday,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: AppColors.primary,
            ),
            child: Text(
              timeList[index],
              style: context.textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.primary,
                onPrimary: AppColors.whiteBG,
                onSurface: AppColors.textBlack,
              ),
              textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
              ))),
          child: child!,
        );
      },
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime(3000),
    );
    if (pickedDate != null) {
      dateController.text =
          "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
    }
  }
}
