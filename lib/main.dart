import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/prototype/main.dart' as Prototype;
import 'package:weather_app/views/heatmap_page.dart';
import 'package:weather_app/views/locations_page.dart';
import 'package:weather_app/views/main_page.dart';
import 'package:weather_app/views/settings_page.dart';
import 'package:weather_app/widgets/shared_axis_page_route.dart';

const USE_PROTOTYPE = true;

void main() {
  runApp(USE_PROTOTYPE ? const Prototype.MyApp() : const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: _onGenerateRoute,
    );
  }

  static Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/': return SharedAxisPageRoute(page: MainPage(), transitionType: SharedAxisTransitionType.horizontal);
      case '/settings': return SharedAxisPageRoute(page: SettingsPage(), transitionType: SharedAxisTransitionType.horizontal);
      case '/locations': return SharedAxisPageRoute(page: LocationsPage(), transitionType: SharedAxisTransitionType.vertical);
      case '/heatmap': return SharedAxisPageRoute(page: HeatmapPage(), transitionType: SharedAxisTransitionType.scaled);
      default: throw "Invalid page route!";
    }
  }
}