import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 12.h),
      child: SizedBox(
        width: 250.w,
        child: FormBuilderTextField(
          obscureText: true,
          name: "password",
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]),
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.lock),
            hintText: "Mot de passe",
          ),
        ),
      ),
    );
  }
}
