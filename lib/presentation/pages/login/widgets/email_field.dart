import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class EmailField extends StatelessWidget {
  const EmailField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 8.h),
      child: SizedBox(
          width: 250.w,
          child: FormBuilderTextField(
            name: "email",
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.email(),
              FormBuilderValidators.required(),
            ]),
            decoration: const InputDecoration(
              hintText: "Email",
              prefixIcon: Icon(
                Icons.person,
              ),
            ),
          )),
    );
  }
}
