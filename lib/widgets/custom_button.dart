import 'package:car_list/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ButtonType {
  elevatedButton,
  textButton,
}

class CustomButton extends StatelessWidget {
  final ButtonType buttonType;
  final String text;
  final VoidCallback? _function;
  final bool isAlternativeVersion;

  const CustomButton(Key? key, this.buttonType, this.text, this._function,
      {this.isAlternativeVersion = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (buttonType) {
      case ButtonType.elevatedButton:
        {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 23.w),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    isAlternativeVersion
                        ? Theme.of(context).primaryColorDark
                        : Theme.of(context).primaryColor),
              ),
              onPressed: _function,
              child: Container(
                child: Text(
                  text.toUpperCase(),
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(14),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                alignment: Alignment.center,
                width: ScreenUtil().setWidth(280),
                height: ScreenUtil().setHeight(50),
              ),
            ),
          );
        }

      case ButtonType.textButton:
        {
          return Padding(
            padding: EdgeInsets.only(
              bottom: 30.h,
              left: 48.w,
              right: 48.w,
            ),
            child: TextButton(
              onPressed: _function,
              child: Container(
                child: Text(
                  text,
                  style: TextStyle(
                    color: ColorsRes.neutralGrayishViolet,
                    fontSize: ScreenUtil().setSp(17),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                alignment: Alignment.center,
                width: ScreenUtil().setWidth(280),
                height: ScreenUtil().setHeight(23),
              ),
            ),
          );
        }

      default:
        {
          return ElevatedButton(onPressed: _function, child: Text(text));
        }
    }
  }
}
