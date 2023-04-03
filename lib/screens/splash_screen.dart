import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
            child: Image.asset(
              'assets/image/logo.png',
            ),
          ),
          const Text(
            'IMPERIAL',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: 3),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Center(
                  child: LocaleText(
                    'HOME',
                    style: TextStyle(
                        letterSpacing: 2,
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
