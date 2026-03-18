import 'package:flutter/material.dart';











class SettingsPageScreens extends StatefulWidget {
  final String title,type;
  const SettingsPageScreens({super.key,required this.title,required this.type});

  @override
  State<SettingsPageScreens> createState() => _SettingsPageScreensState();
}

class _SettingsPageScreensState extends State<SettingsPageScreens> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}




class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


