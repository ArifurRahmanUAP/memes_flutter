import 'package:flutter/material.dart';
import 'package:meme_app/src/core/routes/router.dart';

import '../../core/routes/route_name.dart';
import '../../core/utilities/assets_path.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      RouteGenerator.pushNamed(context, Routes.homeScreen);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              AssetsPath.SPLASH_LOGO,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 100,
            child: Center(
              child: Stack(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(50),
                      ),
                      border: Border.all(
                        width: 3,
                        color: Colors.white,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                    width: 60,
                    child: CircularProgressIndicator(
                      strokeCap: StrokeCap.round,
                      color: Colors.white,
                      strokeWidth: 8,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
