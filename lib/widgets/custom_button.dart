import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ButtonType {
  elevatedButton,
  textButton,
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? _function;

  const CustomButton(
    Key? key,
    this.text,
    this._function,
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23.w),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
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
}
