import 'package:flutter/material.dart';
import 'package:meme_app/src/core/di/app_component.dart';
import 'package:meme_app/src/core/routes/router.dart';
import 'package:meme_app/src/features/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meme App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: RouteGenerator.onRouteGenerate,
      home: const Splashscreen(),
    );
  }
}


