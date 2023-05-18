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
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              left: 0,
              child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
            ),
            const Positioned(
              top: 40,
              bottom: 0,
              right: 0,
              left: 10,
              child: Column(
                children:  [
                  Text(
                  'Welcome!\n',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                  textAlign: TextAlign.center,),
                  Text(
                    'Please accept our access to your location, we need it to deliver your local pollen data \n\nPlease also select if you want to be notified :D\n\nPress "Next" to continue!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,

                  ),
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