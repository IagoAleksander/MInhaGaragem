import 'package:car_list/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/car_cubit.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CarCubit(),
      child: const MaterialApp(
        title: 'Flutter Demo',
        // theme: getThemeData(),
        initialRoute: mainRoute,
        onGenerateRoute: RouteManager.generateRoute,
      ),
    );
  }
}
