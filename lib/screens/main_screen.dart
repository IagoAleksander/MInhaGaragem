import 'package:car_list/utils/router.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed(carInputRoute);
          },
          child: const Text('Main Screen'),
        ),
      ),
    );
  }
}
