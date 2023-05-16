import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('');

    return Scaffold(
      appBar: AppBar(),
      body: IntroductionScreen(
        scrollPhysics: const BouncingScrollPhysics(), //Default is BouncingScrollPhysics
        pages: [
          //List of PageViewModel
          PageViewModel(
            title: 'Title of 1st Page', //Basic String Title
            titleWidget: const Text(
                'Title of 1st Page'), //If you want to use your own Widget
            body: 'Body of 1st Page', //Basic String Body
            bodyWidget: const Text(
                'Body of 1st Page'), //If you want to use your own Widget
            decoration:
                const PageDecoration(), //Page decoration Contain all page customizations
            image: Center(
              child: Image.network(
                  'https://pub.dev/static/img/pub-dev-logo-2x.png?hash=umitaheu8hl7gd3mineshk2koqfngugi'),
            ), //If you want to you can also wrap around Alignment
            reverse: true, //If widget Order is reverse - body before image
            footer: const Text('Footer'), //You can add button here for instance
          ),
        ],
        rawPages: [
          //If you don't want to use PageViewModel you can use this
        ],
        //If you provide both rawPages and pages parameter, pages will be used.
        onChange: (e){
          // When something changes
        },
        onDone: () {
          box.put('introduction', false);
          Navigator.of(context).pushNamed('/');
        },
        skip: const Icon(Icons.skip_next),
        next: const Icon(Icons.forward),
        done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),

        dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: Theme.of(context).progressIndicatorTheme.color!,
            color: Colors.black26,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0))),
      ),
    );
  }
}