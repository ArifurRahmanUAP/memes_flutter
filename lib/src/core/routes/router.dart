import 'package:flutter/material.dart';
import 'package:meme_app/src/core/routes/route_name.dart';
import 'package:meme_app/src/features/home_screen/ui/screens/home_screen.dart';
import 'package:meme_app/src/features/splash_screen/splash_screen.dart';

import '../../features/meme_details_screen/ui/screens/meme_details_screen.dart';

class RouteGenerator {
  static pushNamed(BuildContext context, String pageName,
      {List arguments = const []}) {
    return Navigator.pushNamed(context, pageName, arguments: arguments);
  }
  static pop(BuildContext context) {
    return Navigator.of(context).pop();
  }

  static popAndPushNamed(BuildContext context, String pageName,
      {List arguments = const []}) {
    return Navigator.popAndPushNamed(context, pageName, arguments: arguments);
  }

  static popAll(BuildContext context) {
    return Navigator.of(context).popUntil((route) => false);
  }

  static popUntil(BuildContext context, String pageName) {
    return Navigator.of(context).popUntil(ModalRoute.withName(pageName));
  }

  // ================================== Routing =============================================

  static Route<dynamic>? onRouteGenerate(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashScreenRouteName:
        return MaterialPageRoute(
          builder: (context) => const Splashscreen(),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );

   case Routes.memeDetailsScreen:
     final arguments = routeSettings.arguments as List;
   return MaterialPageRoute(
          builder: (context) => MemeDetailsScreen(memesResponse: arguments[0],),
        );



    }
    return null;
  }
}
