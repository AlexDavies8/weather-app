import 'package:flutter/material.dart';
import 'dart:math' as Math;

class MultistepPage extends StatefulWidget {
  final List<Widget> pages;
  final Function? onDone;

  const MultistepPage({required this.pages, this.onDone, super.key});

  @override
  State<StatefulWidget> createState() => _MultistepPageState();
}

class _MultistepPageState extends State<MultistepPage> {

  final _controller = PageController();
  double currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        currentPage = _controller.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned.fill(
            child: PageView.builder(
              controller: _controller,
              itemCount: widget.pages.length,
              itemBuilder: (BuildContext context, int index) {
                return widget.pages[index];
              }
            )
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (currentPage > 0) Opacity(opacity: Math.min(1.0, currentPage), child: ElevatedButton(onPressed: () => prevPage(), child: Padding(padding: EdgeInsets.all(10), child: const Text("Back")))),
                    Expanded(child: Container()),
                    ElevatedButton(onPressed: () => nextPage(), child: Padding(padding: EdgeInsets.all(10), child: const Text("Next"))),
                  ]
                )  
              )
            )
          )
        ]
      )
    );
  }

  void nextPage() {
    if (currentPage >= widget.pages.length - 1) widget.onDone?.call();
    _controller.nextPage(duration: Duration(milliseconds: 200), curve: Curves.easeInOutCubic);
  }

  void prevPage() {
    _controller.previousPage(duration: Duration(milliseconds: 200), curve: Curves.easeInOutCubic);
  }
}