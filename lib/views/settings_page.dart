import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Column(
        children: [
          ElevatedButton(onPressed: () => resetWelcome(), child: Text("Reset welcome screen bool"))
        ]
      )
    );
  }

  void resetWelcome() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('completedWelcome', false);
  }
}