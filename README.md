# weather_app

A Pollen Tracker App for the Interaction Design course, Group 23.

This app allows for users to see realtime and future forecast data for pollen in any given area within the United Kingdom, North America, Australia, and some select areas of Europe (subject to the regional data provided by Ambee).

It makes use of the BLoC design pattern to help separate the UI from the data and business logic, and includes some custom widget primitives using CustomPainter to create better circular progress bars than the default ones provided by Flutter.

Mock data can be used for development purposes via the flag in the ambee_api.dart file, along with a path to that mock data. Keys are stored in the keys.dart file, instead of in environment variables, as this is simpler for the development of the prototype. There is also an additional flag in the parallax_background.dart file to switch to an alternative flat UI style for the main forecast page.

A windows build of the app can be downloaded from '', although some features such as location permissions popups aren't available on the Windows platform, so building a debug build for Android (or iOS) would better show off the features of the app.