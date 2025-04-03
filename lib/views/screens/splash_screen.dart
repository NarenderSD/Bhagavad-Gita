import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/gita_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      Navigator.of(context).pushReplacementNamed('bhagavad_gita');
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<GitaProvider>(context, listen: false)
      ..chaptersJson()
      ..verseJson()
      ..verseTranslationJson()
      ..commentaryJson()
      ..getBookMark();

    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/splashbkg.png'),
                  opacity: 1)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 300),
              const CircularProgressIndicator(color: Colors.white),
              Text("Bhagavad Gita",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.brown.shade900,
                      backgroundColor: Colors.white.withOpacity(0.4)),
                  textScaleFactor: 2),
              Text(
                "Made with love 💕 in India",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.brown.shade900,
                    backgroundColor: Colors.white.withOpacity(0.4)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
