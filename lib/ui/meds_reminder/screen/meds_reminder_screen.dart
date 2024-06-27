import 'package:flutter/material.dart';

import '../widget/list_date.dart';

class MedsReminderScreen extends StatefulWidget {
  const MedsReminderScreen({super.key});

  @override
  State<MedsReminderScreen> createState() => _MedsReminderScreenState();
}

class _MedsReminderScreenState extends State<MedsReminderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListDate(
            dateSelected: (date) {},
          ),
        ],
      ),
    );
  }
}
