import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BaseApp extends StatefulWidget {
  final Widget? child;

  const BaseApp({super.key, this.child});

  @override
  State<BaseApp> createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: const TextScaler.linear(1.2),
      ),
      child: widget.child!,
    );
  }
}
