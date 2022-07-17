import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_care/router/navigations/side_menu.dart';
import 'package:smart_care/router/routing_pages.dart';

import 'router/navigations/global.dart';
import 'router/navigations/side_menu_display_mode.dart';
import 'router/navigations/side_menu_style.dart';
import 'web_main.dart';

const _seedColor = Color(0x0E4DA4FD);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    return MaterialApp(
      title: 'Smart Care',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: _seedColor, brightness: Brightness.light),
        textTheme: GoogleFonts.notoSansNKoTextTheme(theme.textTheme),
      ),
      home: WebMain(),
    );
  }
}
