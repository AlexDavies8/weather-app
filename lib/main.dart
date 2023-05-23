import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/bloc/forecast/forecast_bloc.dart';
import 'package:weather_app/bloc/forecast/forecast_event.dart';
import 'package:weather_app/bloc/forecast/forecast_state.dart';
import 'package:weather_app/models/location.dart';
import 'package:weather_app/views/heatmap_page.dart';
import 'package:weather_app/views/locations_page.dart';
import 'package:weather_app/views/main_page.dart';
import 'package:weather_app/views/settings_page.dart';
import 'package:weather_app/views/welcome_page.dart';
import 'package:weather_app/widgets/shared_axis_page_route.dart';
void main() async{
  runApp(const MyApp());
}

class PersistantPages {
  static final mainPage = MainPage();
  static final settingsPage = SettingsPage();
  static final locationsPage = LocationsPage();
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
            return Column(
                children: const [CircularProgressIndicator()]);
          default:
            return BlocProvider<ForecastBloc>(
              create: (_) {
                final location = Location(
                  displayName: "My Location",
                  requestLocation: LatLngLocation.fromCurrentLocation()
                );
                final bloc = ForecastBloc(ForecastState.empty());
                bloc.add(AddLocation(location));
                bloc.add(SelectLocation(location));
                return bloc;
              },
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  colorScheme: const ColorScheme.dark(primary: Colors.blue),
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
      case '/': return SharedAxisPageRoute(page: PersistantPages.mainPage, transitionType: SharedAxisTransitionType.horizontal);
      case '/settings': return SharedAxisPageRoute(page: PersistantPages.settingsPage, transitionType: SharedAxisTransitionType.horizontal);
      case '/locations': return SharedAxisPageRoute(page: PersistantPages.locationsPage, transitionType: SharedAxisTransitionType.vertical);
      case '/heatmap': return SharedAxisPageRoute(page: HeatmapPage(), transitionType: SharedAxisTransitionType.scaled);
      default: throw "Invalid page route!";
    }
  }
}



