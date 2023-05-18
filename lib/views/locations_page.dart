// import 'package:flutter/material.dart';
//
// class LocationsPage extends StatelessWidget {
//   const LocationsPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//         appBar: AppBar(title: const Text("Locations")),
//         body: ListView(
//           children: const [
//             // Locations(),
//             MyHomePage(title: "title"),
//           ],
//         )
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   TextEditingController controller = TextEditingController();
//
//   String _note = '';
//   final List<String> _notes = ['Default first note'];
//
//   _showAlertDialog() {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             actions: [
//               TextButton(
//                   onPressed: () {
//                     setState(() {
//                       _notes.add(_note);
//                       controller.clear();
//                     });
//                     Navigator.pop(context);
//                   },
//                   child: const Text('Save Note'))
//             ],
//             title: const Text('Enter Note'),
//             content: TextField(
//               controller: controller,
//               decoration:
//               const InputDecoration(contentPadding: EdgeInsets.all(10)),
//               onChanged: (val) {
//                 setState(() {
//                   _note = val;
//                 });
//               },
//             ),
//           );
//         });
//   }
//
//   _resetNotes() {
//     setState(() {
//       _notes
//           .retainWhere((element) => element.toString() == 'Default first note');
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: ListView.builder(
//           itemCount: _notes.length,
//           itemBuilder: (context, index) {
//             return ListTile(
//               leading: Text(index.toString()),
//               title: Text(_notes[index].toString()),
//             );
//           }),
//       floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             onPressed: _showAlertDialog,
//             tooltip: 'AddNote',
//             child: const Icon(Icons.add),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           FloatingActionButton(
//             onPressed: _resetNotes,
//             tooltip: 'Reset',
//             child: const Icon(Icons.replay),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

void main() {
  runApp(const LocationsPage());
}

class LocationsPage extends StatelessWidget {
  const LocationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Locations")),
      body: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controller = TextEditingController();

  String _note = '';
  final List<String> _notes = ['Default first note'];

  _showAlertDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      _notes.add(_note);
                      controller.clear();
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Add city'))
            ],
            // title: const Text('Add new city'),
            content: TextField(
              controller: controller,
              decoration:
              const InputDecoration(contentPadding: EdgeInsets.all(10)),
              onChanged: (val) {
                setState(() {
                  _note = val;
                });
              },
            ),
          );
        });
  }

  _deleteNote(index) {
    setState(() {
      _notes.remove(_notes[index].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: _notes.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: const FlutterLogo(size: 72.0),
                title: Text(_notes[index].toString()),
                subtitle: const Text('...'),
                trailing: FloatingActionButton(
                  onPressed: () => _deleteNote(index),
                  tooltip: 'Reset',
                  child: const Icon(Icons.delete),
                )
              ),
            );
          }),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _showAlertDialog,
            tooltip: 'AddNote',
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}