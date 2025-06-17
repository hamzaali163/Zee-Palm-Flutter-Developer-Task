import 'package:assesment_project/utils/routenames.dart';
import 'package:assesment_project/view/auth/login_screen.dart';
import 'package:assesment_project/view/auth/sign_up.dart';
import 'package:assesment_project/view/home/bottomnav.dart';
import 'package:assesment_project/view/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Generateroutes {
  Route<dynamic> generateroutes(RouteSettings route) {
    switch (route.name) {
      case RouteNames.loginscreen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) {}, // Add your actual provider class here
            child: const LoginScreen(),
          ),
        );

      case RouteNames.signupscreen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) {}, // Add your actual provider class here
            child: const SignUpScreen(),
          ),
        );

      case RouteNames.home:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) {}, // Add your actual provider class here
            child: const HomeScreen(),
          ),
        );

      case RouteNames.bottomnab:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) {}, // Add your actual provider class here
            child: const BottomNavScreen(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Column(children: [Center(child: Text('error, no screen found'))]),
            );
          },
        );
    }
  }
}
