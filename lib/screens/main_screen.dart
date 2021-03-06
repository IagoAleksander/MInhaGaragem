import 'package:car_list/cubit/car_cubit.dart';
import 'package:car_list/data/model/carro.dart';
import 'package:car_list/utils/constants.dart';
import 'package:car_list/utils/router.dart';
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
  void initState() {
    context.read<CarCubit>().getAllCars();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16.h),
            Text(
              Texts.mainScreenTitle,
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
                child: BlocBuilder<CarCubit, List<Carro>>(
                    builder: (context, state) {
                  return CustomButton(
                    UniqueKey(),
                    context.read<CarCubit>().isThereACarSelected()
                        ? Texts.mainScreenButtonEditCarOption
                        : Texts.mainScreenButtonAddCarOption,
                    () {
                      Navigator.of(context).pushNamed(
                        carInputRoute,
                        arguments: context.read<CarCubit>().getCar(
                              context.read<CarCubit>().selectedCarId,
                            ),
                      );
                    },
                  );
                }),
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
          Text(Texts.mainScreenEmptyStateDescriptionText),
          Spacer(),
        ],
      ),
    );
  }

  _displayContentList() {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          mainAxisExtent: 150.h
        ),
        itemCount: context.read<CarCubit>().state.length,
        itemBuilder: (_, index) {
          var model = context.read<CarCubit>().state.reversed.toList()[index];
          return CardCar(
            UniqueKey(),
            model,
            () => context.read<CarCubit>().selectCarToggle(model),
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
          Texts.mainScreenDeleteConfirmationDialogText,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
                Texts.mainScreenDeleteConfirmationDialogCancelOptionText),
          ),
          TextButton(
            onPressed: () {
              context.read<CarCubit>().removeCar(model);
              Navigator.pop(context);
            },
            child: const Text(
                Texts.mainScreenDeleteConfirmationDialogConfirmOptionText),
          ),
        ],
      ),
    );
  }
}
