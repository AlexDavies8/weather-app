import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _settings = Settings();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: AnimatedBuilder(
        animation: _settings,
        builder: (context, child) {
          if (_settings.hasData) return buildSettingsList();
          return const Center(child: CircularProgressIndicator());
        }
      )
    );
  }

  Widget buildSettingsList() {
    final theme = Theme.of(context);
    return SizedBox.expand(
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              hoverColor: theme.hoverColor,
              onTap: () => _settings.notifications = !_settings.notifications,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(right: 20), child: Icon(Icons.notifications)),
                    Expanded(child: Text("Enable Notifications", style: TextStyle(fontSize: 18))),
                    Switch(value: _settings.notifications, onChanged: (value) => _settings.notifications = value)
                  ]
                )
              )
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              hoverColor: theme.hoverColor,
              onTap: openLocationSettings,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    Expanded(child: Text("Location Settings", style: TextStyle(fontSize: 18))),
                    Padding(padding: EdgeInsets.only(left: 20), child: Icon(Icons.exit_to_app)),
                  ]
                )
              )
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              hoverColor: theme.hoverColor,
              onTap: _settings.resetWelcomeScreen,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    Expanded(child: Text("Reset Welcome Page", style: TextStyle(fontSize: 18))),
                    Padding(padding: EdgeInsets.only(left: 20), child: Icon(Icons.build)),
                  ]
                )
              )
            ),
          )
        ]
      )
    );
  }

  void setNotifications(SharedPreferences prefs, bool value) {
    setState(() {
      prefs.setBool("notifications", value);
    });
  }

  void openLocationSettings() {
    Geolocator.openLocationSettings().catchError((_) => print("Can't open settings on current platform")).ignore();
  }

  void resetWelcome() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('completedWelcome', false);
  }
}

class Settings extends ChangeNotifier {
  SharedPreferences? _prefs;
  bool hasData = false;
  late bool _notifications;
  bool get notifications => _notifications;
  set notifications(bool value) {
    _prefs?.setBool("notifications", value).then((_) {
      _notifications = value;
      notifyListeners();
    });
  }

  Settings() {
    SharedPreferences.getInstance().then((value) => _loadPrefs(value));
  }

  void resetWelcomeScreen() {
    _prefs?.setBool("completedWelcome", false);
  }

  _loadPrefs(SharedPreferences prefs) {
    _prefs = prefs;
    hasData = true;
    _notifications = _prefs!.getBool("notifications") ?? true;
    notifyListeners();
  }
}