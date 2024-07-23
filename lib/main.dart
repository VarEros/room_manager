import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:room_manager/screen.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final ThemeData _theme = ThemeData(
    fontFamily: GoogleFonts.raleway().fontFamily,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.indigo,
    ),
    brightness: Brightness.light,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        SfGlobalLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
      ],
      locale: const Locale('es'),
      themeMode: ThemeMode.light,
      darkTheme: _theme.copyWith(
        brightness: Brightness.dark,
      ),
      theme: _theme,
      debugShowCheckedModeBanner: false,
      home: const Screen()
    );
  }
}
