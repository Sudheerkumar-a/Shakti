import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shakti/core/constants/assets.dart';
import 'package:shakti/presentation/ui/screens/home_screen.dart';
import '../../../approutes/app_routes.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer.periodic(const Duration(seconds: 3), (Timer t) {
      t.cancel();
      Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
    });
    return Scaffold(
      //backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: RadialGradient(
            colors: [
              Color.fromRGBO(255, 255, 255, 1),
              Color.fromRGBO(253, 225, 235, 1),
            ],
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                Assets.splashLogo,
                width: 150,
                height: 150,
                fit: BoxFit.fill,
              ),
              Text(
                "SHAKTI",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  letterSpacing: 5.1,
                  height: 1.5,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "The pink sphere of\nsafety & support",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  letterSpacing: 2.1,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
