import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/bloc/bloc_provider.dart';
import 'package:weather_app/bloc/forecast_bloc.dart';
import 'package:weather_app/views/heatmap_page.dart';
import 'package:weather_app/views/locations_page.dart';
import 'package:weather_app/views/main_page.dart';
import 'package:weather_app/views/settings_page.dart';
import 'package:weather_app/views/welcome_page.dart';
import 'package:weather_app/widgets/shared_axis_page_route.dart';

void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            return BlocProvider(
              bloc: ForecastBloc(),
                child: MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
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
                initialRoute: snapshot.data?.getBool("completedWelcome") ?? false ? '/' : '/welcome',
                onGenerateRoute: _onGenerateRoute,
              )
            ); 
        }
      },
    );
    
  }

  static Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/welcome': return SharedAxisPageRoute(page: WelcomePage(), transitionType: SharedAxisTransitionType.horizontal);
      case '/': return SharedAxisPageRoute(page: MainPage(), transitionType: SharedAxisTransitionType.horizontal);
      case '/settings': return SharedAxisPageRoute(page: SettingsPage(), transitionType: SharedAxisTransitionType.horizontal);
      case '/locations': return SharedAxisPageRoute(page: LocationsPage(), transitionType: SharedAxisTransitionType.vertical);
      case '/heatmap': return SharedAxisPageRoute(page: HeatmapPage(), transitionType: SharedAxisTransitionType.scaled);
      default: throw "Invalid page route!";
    }
  }
}



