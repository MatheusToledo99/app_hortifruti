// ignore_for_file: library_private_types_in_public_api

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app_hortifruti/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(seconds: 4), () => Get.offAllNamed(Routes.cities));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.2,
          child: Image.asset(
            'assets/images/backgroundSplash.jpg',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  height: 50,
                  child: AnimatedTextKit(
                    pause: Duration.zero,
                    repeatForever: true,
                    animatedTexts: [
                      FadeAnimatedText(
                        'Hortifruti',
                        textStyle: const TextStyle(
                            color: Colors.green,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                const CircularProgressIndicator(
                  color: Colors.blue,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
