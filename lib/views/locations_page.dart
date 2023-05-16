import 'package:flutter/material.dart';

class LocationsPage extends StatelessWidget {
  const LocationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    'Oeschinen Lake Campground',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Kandersteg, Switzerland',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    print('hello');
    return Scaffold(
        appBar: AppBar(title: const Text("Locations")),
        body: ListView(
          children: [
            titleSection,
            const Locations(),
          ],
        )
    );

    // return MaterialApp(
    //   title: 'Location Page',
    //   home: Scaffold(
    //     appBar: AppBar(
    //       title: const Text('Location'),
    //     ),
    //     body: ListView(
    //       children: [
    //         titleSection,
    //         const LocationsPage(),
    //       ],
    //     ),
    //   ),
    // );
  }

}
class Locations extends StatefulWidget {
  const Locations({super.key});

  @override
  State<Locations> createState() => _LocationState();
}

class _LocationState extends State<Locations> {
  // int _cityID = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(0),
          child: IconButton(
            padding: const EdgeInsets.all(0),
            alignment: Alignment.centerRight,
            icon: const Icon(Icons.star),
            color: Colors.red[500],
            onPressed: () {},
          ),
        ),
        const SizedBox(
          width: 18,
          child: SizedBox(
            child: Text('test'),
          ),
        ),
      ],
    );
  }
}