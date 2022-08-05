// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart'
    show PathUrlStrategy, setUrlStrategy;

import 'common_widgets/home_page.dart';

import 'routes/route_name.dart';
import 'routes/route_generator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // cameras = await availableCameras(); // From video_screen.dart
  runApp(const MyApp());

  setUrlStrategy(PathUrlStrategy()); // to remove # at url
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart English',
      theme: buildThemeData(context),
      // debugShowCheckedModeBanner: false,
      builder: (context, child) => HomePage(child: child!),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: RouteName.ONBOARD,
    );
  }

  ThemeData buildThemeData(BuildContext context,
      {Color seedColor = const Color(0xFF4DA4FD)}) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.light,
      ),
      textTheme: GoogleFonts.notoSansNKoTextTheme(Theme.of(context).textTheme),
    );
  }
}
