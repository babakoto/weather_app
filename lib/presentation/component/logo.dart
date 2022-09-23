import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/generated/assets.dart';

class Logo extends StatelessWidget {
  final double? width;
  final double? height;

  const Logo({Key? key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 120.w,
      height: height ?? 90.h,
      child: Image.asset(
        Assets.imagesLogoDark,
      ),
    );
  }
}
