import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/widgets/multistep_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MultistepPage(
      onDone: () => _completedWelcome(context),
      pages: [
        Container(
          child: Text("Notifications")
        ),
        Container(
          child: Text("Location")
        )
      ]
    );
  }

  void _completedWelcome(BuildContext context) async {
    Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('completedWelcome', true);
  }
}