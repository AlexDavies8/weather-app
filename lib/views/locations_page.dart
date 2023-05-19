import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/forecast/forecast_bloc.dart';
import 'package:weather_app/bloc/forecast/forecast_event.dart';

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
      appBar: AppBar(title: Text("Locations")),
      body: BlocBuilder<ForecastBloc, ForecastState>(
        bloc: forecastBloc,
        builder: (context, state) {
          return Column(children: state.locations.map((location) {
            final selected = location == state.selectedLocation;
            return Material(
              color: selected ? theme.focusColor : Colors.transparent,
              child: InkWell(
                hoverColor: theme.hoverColor,
                onTap: () {
                  forecastBloc.add(SelectLocation(location));
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Row(
                    children: [
                      Icon(Icons.place, color: selected ? theme.colorScheme.primary : theme.textTheme.labelLarge!.color),
                      SizedBox(width: 16),
                      Expanded(child: Text(location.displayName, style: TextStyle(fontSize: 18))),
                      if (location.displayName != "My Location") IconButton(
                        splashRadius: 20,
                        onPressed: () => forecastBloc.add(RemoveLocation(location)),
                        tooltip: 'Remove',
                        icon: const Icon(Icons.delete),
                      )
                    ]
                  )
                )
              )
            );
          }).toList() + [
            Material(
              color: Colors.transparent,
              child: InkWell(
                hoverColor: theme.hoverColor,
                onTap: () => _showAddDialog(forecastBloc),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 16),
                      Expanded(child: Text("Add Location", style: TextStyle(fontSize: 18))),
                    ]
                  )
                )
              )
            )
          ]
          );
        },
      )
    );
  }
}