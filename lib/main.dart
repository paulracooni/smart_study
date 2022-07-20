import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'web_main.dart';

const _seedColor = Color(0xFF4DA4FD);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Care',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seedColor,
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.notoSansNKoTextTheme(Theme.of(context).textTheme),
      ),
      home: const WebMain(),
    );
  }
}
