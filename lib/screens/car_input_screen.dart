import 'package:car_list/utils/router.dart';
import 'package:flutter/material.dart';

class CarInputScreen extends StatelessWidget {
  const CarInputScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).disabledColor,
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed(mainRoute);
          },
          child: const Text('Car Input Screen'),
        ),
      ),
    );
  }
}
