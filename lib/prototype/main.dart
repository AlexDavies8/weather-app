import 'package:weather_app/prototype/ambee_api.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/prototype/main_page.dart';
import 'package:weather_app/prototype/settingspage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.windows: SharedAxisPageTransitionsBuilder(
              transitionType: SharedAxisTransitionType.horizontal,
            ),
            TargetPlatform.android: SharedAxisPageTransitionsBuilder(
              transitionType: SharedAxisTransitionType.horizontal,
            ),
            TargetPlatform.iOS: SharedAxisPageTransitionsBuilder(
              transitionType: SharedAxisTransitionType.horizontal,
            ),
          },
        ),
      ),
      onGenerateRoute: _onGenerateRoute,
      initialRoute: '/',
    );
  }

  static Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/locations':
        return SharedAxisPageRoute(
          transitionType: SharedAxisTransitionType.vertical,
          page: Scaffold(appBar: AppBar()),
        );
      case '/map':
        return SharedAxisPageRoute(
          transitionType: SharedAxisTransitionType.scaled,
          page: Scaffold(appBar: AppBar()),
        );
      case '/settings':
        return SharedAxisPageRoute(
          transitionType: SharedAxisTransitionType.horizontal,
          page: const SettingsPage(),
        );
      case '/':
        return SharedAxisPageRoute(
          transitionType: SharedAxisTransitionType.horizontal,
          page: const MainPage(AmbeeApi("testKey")),
        );
    }
    throw UnsupportedError('Unknown route: ${settings.name}');
  }
}

class SharedAxisPageRoute extends PageRouteBuilder {
  SharedAxisPageRoute({required Widget page, required SharedAxisTransitionType transitionType}) : super(
    pageBuilder: (
      BuildContext context,
      Animation primaryAnimation,
      Animation secondaryAnimation,
    ) => page,
    transitionsBuilder: (
      BuildContext context,
      Animation<double> primaryAnimation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) {
      return SharedAxisTransition(
        animation: primaryAnimation,
        secondaryAnimation: secondaryAnimation,
        transitionType: transitionType,
        child: child,
      );
    },
  );
}