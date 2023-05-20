import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/forecast/forecast_bloc.dart';
import 'package:weather_app/bloc/forecast/forecast_event.dart';
import 'package:weather_app/widgets/settings_item.dart';

import '../bloc/forecast/forecast_state.dart';
import '../models/location.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({Key? key}) : super(key: key);

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  TextEditingController controller = TextEditingController();

  void _showAddDialog(ForecastBloc bloc) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            TextButton(
            onPressed: () {
              final location = Location(
                displayName: controller.text,
                requestLocation: PlacewiseLocation(placename: controller.text)
              );
              bloc.add(AddLocation(location));
              controller.clear();
              Navigator.pop(context);
            },
            child: const Text('Add Location'))
          ],
          // title: const Text('Add new city'),
          content: TextField(
            autofocus: true,
            controller: controller,
            decoration: const InputDecoration(contentPadding: EdgeInsets.all(10)),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final forecastBloc = BlocProvider.of<ForecastBloc>(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Locations")),
      body: BlocBuilder<ForecastBloc, ForecastState>(
        bloc: forecastBloc,
        builder: (context, state) {
          return Column(children: state.locations.map((location) {
            final selected = location == state.selectedLocation;
            return SettingsItem(
              text: location.displayName,
              leading: Icon(Icons.place, color: selected ? theme.colorScheme.primary : theme.textTheme.labelLarge!.color),
              onTap: () {
                forecastBloc.add(SelectLocation(location));
                Navigator.pop(context);
              },
              trailing: location.displayName == "My Location" ? null : SizedBox(height: 20, child: IconButton(
                  splashRadius: 20,
                  onPressed: () => forecastBloc.add(RemoveLocation(location)),
                  tooltip: 'Remove',
                  icon: const Icon(Icons.delete),
                )
              )
            );
          }).toList() + [
            SettingsItem(
              text: "Add Location",
              leading: const Icon(Icons.add),
              onTap: () => _showAddDialog(forecastBloc)
            )
          ]
          );
        },
      )
    );
  }
}