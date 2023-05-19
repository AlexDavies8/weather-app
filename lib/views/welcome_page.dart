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
        Stack(
          children:  [
            Positioned.fill(
              child: Image.asset(
                'assets/images/background.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 40,
              bottom: 40,
              right: 40,
              left: 40,
              child: Column(
                children: [
                  Text(
                    'Location',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                    textAlign: TextAlign.center
                  ),
                  Flexible(flex: 3, child: Container()),
                  Expanded(
                    flex: 4,
                    child: Text(
                      'Providing access to your location data let\'s us give more accurate pollen estimates nearby!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: "Varela"
                      ),
                      textAlign: TextAlign.center,
                    )
                  ),
                  Flexible(flex: 3, child: Container()),
                ]
              ),
            ),
          ],
        ),
        Stack(
          children:  [
            Positioned.fill(
              child: Image.asset(
                'assets/images/background.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 40,
              bottom: 40,
              right: 40,
              left: 40,
              child: Column(
                children: [
                  Text(
                    'Notifications',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                    textAlign: TextAlign.center
                  ),
                  Flexible(flex: 3, child: Container()),
                  Expanded(
                    flex: 4,
                    child: Text(
                      'We can send you warnings for high pollen levels nearby\n\nYou can always turn notifications off later, if you change your mind',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: "Varela"
                      ),
                      textAlign: TextAlign.center,
                    )
                  ),
                  Flexible(flex: 3, child: Container()),
                ]
              ),
            ),
          ],
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