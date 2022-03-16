import 'package:car_list/cubit/car_cubit.dart';
import 'package:car_list/data/model/carro.dart';
import 'package:car_list/widgets/card_car.dart';
import 'package:car_list/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16.h),
            Text(
              "My Garage",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(height: 16.h),
            Divider(
              height: 1,
              thickness: 1,
              color: Theme.of(context).dividerColor,
            ),
            BlocBuilder<CarCubit, List<Carro>>(
              builder: (context, state) {
                return state.isEmpty
                    ? _displayEmptyState()
                    : _displayContentList();
              },
            ),
            Container(
              color: Theme.of(context).primaryColorDark,
              height: 100.h,
              child: Padding(
                padding: EdgeInsets.all(25.w),
                child: CustomButton(
                  UniqueKey(),
                  ButtonType.elevatedButton,
                  "Adicionar carro",
                  () {
                    context.read<CarCubit>().addCar(
                          Carro(
                            id: context.read<CarCubit>().state.length,
                            placa: context
                                .read<CarCubit>()
                                .state
                                .length
                                .toString(),
                          ),
                        );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _displayEmptyState() {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Spacer(),
          Text("Adicione um carro para começar!"),
          Spacer(),
        ],
      ),
    );
  }

  _displayContentList() {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.3,
        ),
        itemCount: context.read<CarCubit>().state.length,
        itemBuilder: (_, index) {
          var model = context.read<CarCubit>().state.reversed.toList()[index];
          return CardCar(
            UniqueKey(),
            model,
            () => context.read<CarCubit>().selectCar(model),
            () => _showDialog(model),
          );
        },
      ),
    );
  }

  _showDialog(Carro model) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text(
          "Do you really want to remove the car from the list?",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              context.read<CarCubit>().removeCar(model);
              Navigator.pop(context);
            },
            child: const Text("Remove"),
          ),
        ],
      ),
    );
  }
}
