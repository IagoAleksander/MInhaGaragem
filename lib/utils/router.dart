import 'package:car_list/data/model/carro.dart';
import 'package:car_list/screens/car_input_screen.dart';
import 'package:car_list/screens/main_screen.dart';
import 'package:flutter/material.dart';

const String mainRoute = '/';
const String carInputRoute = '/carInput';

class RouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainRoute:
        return MaterialPageRoute(builder: (_) => const MainScreen());

      case carInputRoute:
        var car = settings.arguments as Carro?;
        return MaterialPageRoute(builder: (_) => CarInputScreen(car: car));

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
