import 'package:flutter/material.dart';
import 'dart:math' as Math;

/// A class representing a page with multiple steps for the onboarding process
class MultistepPage extends StatefulWidget {
  final List<Widget> pages;
  final Function? onDone;
  final Future<void> Function(int)? onNextPage;

  const MultistepPage({required this.pages, this.onDone, this.onNextPage, super.key});

  @override
  State<StatefulWidget> createState() => _MultistepPageState();
}

/// A class representing the state of a [MultistepPage]
class _MultistepPageState extends State<MultistepPage> {

  final _controller = PageController();
  double currentPage = 0.0; // The current step of the MultistepPage

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
                    if (currentPage > 0) Opacity(opacity: Math.min(1.0, currentPage), child: ElevatedButton(onPressed: () => prevPage(), child: Padding(padding: EdgeInsets.all(10), child: const Text("Back")))), // Hide back button on first page
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

  // Method to transition to the next page
  void nextPage() async {
    await widget.onNextPage?.call(currentPage.toInt());
    if (currentPage >= widget.pages.length - 1) widget.onDone?.call();
    _controller.nextPage(duration: Duration(milliseconds: 200), curve: Curves.easeInOutCubic);
  }

  // Method to transition to the previous page
  void prevPage() async {
    _controller.previousPage(duration: Duration(milliseconds: 200), curve: Curves.easeInOutCubic);
  }
}