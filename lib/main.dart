import 'package:bhagavad_gita/controllers/theme_provider.dart';
import 'package:bhagavad_gita/views/screens/bhagavad_gita.dart';
import 'package:bhagavad_gita/views/screens/bookmark_screen.dart';
import 'package:bhagavad_gita/views/screens/chapter_screen.dart';
import 'package:bhagavad_gita/views/screens/splash_screen.dart';
import 'package:bhagavad_gita/views/screens/verse_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/gita_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GitaProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bhagavad Gita',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: const ColorScheme.light(),
          primarySwatch: Colors.blue,
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: const ColorScheme.dark(
            primary: Colors.white,
          ),
        ),
        // themeMode: ThemeMode.system,
        themeMode: (themeProvider.isDark) ? ThemeMode.dark : ThemeMode.light,
        routes: {
          "/": (context) => const SplashScreen(),
          "bhagavad_gita": (context) => const BhagavadGita(),
          "chapter_screen": (context) => const ChapterScreen(),
          "verse_details": (context) => const VerseDetails(),
          "bookmark_screen": (context) => const BookMarkScreen(),
        });
  }
}
