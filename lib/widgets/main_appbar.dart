import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Colors.black45, Colors.transparent]),
        ),
      ),
      title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        IconButton(
          onPressed: () => Navigator.of(context).pushNamed("/heatmap"),
          icon: const Icon(
            Icons.map,
            size: 24.0,
          ),
        ),
        const Expanded(child: SizedBox()),
        const Icon(Icons.place_outlined),
        const SizedBox(width: 10),
        const Text("Cambridge", style: TextStyle(fontSize: 24, fontFamily: 'Nunito')),
        const Expanded(child: SizedBox()),
        IconButton(
          onPressed: () => Navigator.of(context).pushNamed("/locations"),
          icon: const Icon(
            Icons.list,
            size: 24.0,
          ),
        ),
        IconButton(
          onPressed: () => Navigator.of(context).pushNamed("/settings"),
          icon: const Icon(
            Icons.settings,
            size: 24.0,
          ),
        )
      ]),
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      foregroundColor: Colors.white,
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
