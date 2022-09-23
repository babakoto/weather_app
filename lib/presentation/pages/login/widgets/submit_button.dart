import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const SubmitButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: 250.w,
      height: 50.h,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text("Se connecter", style: textTheme.bodyText1),
      ),
    );
  }
}
