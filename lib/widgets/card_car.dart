import 'package:car_list/data/model/carro.dart';
import 'package:car_list/utils/colors.dart';
import 'package:car_list/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CardCar extends StatelessWidget {
  final Carro car;
  final VoidCallback? _clickFunction;
  final VoidCallback? _removeFunction;

  const CardCar(
    Key? key,
    this.car,
    this._clickFunction,
    this._removeFunction,
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _clickFunction,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
          side: car.isSelected
              ? const BorderSide(color: ColorsRes.primaryCyan, width: 2.0)
              : const BorderSide(color: ColorsRes.backgroundWhite, width: 2.0),
        ),
        color: ColorsRes.backgroundWhite,
        child: Padding(
          padding: EdgeInsets.all(12.h),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: _removeFunction,
                  child: SvgPicture.asset(
                    IconPaths.deleteIconPath,
                    height: 18.h,
                    color: ColorsRes.neutralGrayishViolet,
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 23.w, top: 16.h, right: 23.w, bottom: 8.h),
                    child: Stack(
                      children: [
                        SvgPicture.asset(
                          IconPaths.carIconPath,
                          height: 64.h,
                          color: car.cor != null
                              ? Color(int.parse(car.cor ?? "-1"))
                              : ColorsRes.neutralGray,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    car.placa ?? "",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
