import 'dart:math' as math;

import 'package:car_list/cubit/car_cubit.dart';
import 'package:car_list/data/model/carro.dart';
import 'package:car_list/utils/constants.dart';
import 'package:car_list/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/src/provider.dart';

Color pickerColor = const Color(0xff443a49);
Color currentColor = const Color(0xff443a49);

class CarInputScreen extends StatefulWidget {
  const CarInputScreen({Key? key, this.car}) : super(key: key);

  final Carro? car;

  @override
  State<CarInputScreen> createState() => _CarInputScreenState();
}

class _CarInputScreenState extends State<CarInputScreen> {
  final plate = TextEditingController();

  @override
  void initState() {
    if (widget.car != null) {
      if (widget.car?.placa != null) {
        plate.text = widget.car!.placa!;
      }
      if (widget.car?.cor != null) {
        changeColor(Color(int.parse(widget.car!.cor!)));
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16.h),
            Text(
              Texts.carInputScreenTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(height: 16.h),
            Divider(
              height: 1,
              thickness: 1,
              color: Theme.of(context).dividerColor,
            ),
            const Spacer(),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 50.w, right: 20.w),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Texts.carInputScreenPlateLabel,
                        style: Theme.of(context).textTheme.subtitle1,
                      )),
                ),
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(right: 50.w),
                      child: TextFormField(
                        controller: plate,
                        decoration: const InputDecoration(counterText: ""),
                        autocorrect: false,
                        maxLength: 10,
                      )),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 50.w, right: 36.w),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Texts.carInputScreenColorLabel,
                        style: Theme.of(context).textTheme.subtitle1,
                      )),
                ),
                ElevatedButton(
                  onPressed: () => callDialog(),
                  child: null,
                  style: ElevatedButton.styleFrom(primary: pickerColor),
                )
              ],
            ),
            const Spacer(),
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: SvgPicture.asset(
                IconPaths.carIconPath,
                height: 128.h,
                color: pickerColor,
              ),
            ),
            Container(
              color: Theme.of(context).primaryColorDark,
              height: 100.h,
              child: Padding(
                padding: EdgeInsets.all(25.w),
                child: CustomButton(
                  UniqueKey(),
                  Texts.carInputScreenButtonText,
                  () {
                    _upsertCar();
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  callDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(Texts.carInputScreenColorDialogTitle),
        content: SingleChildScrollView(
          child: MaterialPicker(
            pickerColor: pickerColor,
            onColorChanged: changeColor,
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text(Texts.carInputScreenColorDialogConfirmButtonText),
            onPressed: () {
              setState(() => currentColor = pickerColor);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  _upsertCar() {
    if (widget.car != null) {
      _updateCar();
    } else {
      _addCar();
    }
  }

  _updateCar() {
    context.read<CarCubit>().updateCar(
          Carro(
            id: widget.car?.id,
            placa: plate.text,
            cor: pickerColor.value.toString(),
          ),
        );
  }

  void _addCar() {
    context.read<CarCubit>().addCar(
          Carro(
            placa: plate.text,
            cor: pickerColor.value.toString(),
          ),
        );
  }
}
