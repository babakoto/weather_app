import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/dto/auth/sign_in_dto.dart';
import 'package:weather_app/generated/assets.dart';
import 'package:weather_app/presentation/blocs/blocs/auth/sign_in/sign_in_bloc.dart';
import 'package:weather_app/presentation/component/logo.dart';
import 'package:weather_app/presentation/pages/login/widgets/email_field.dart';
import 'package:weather_app/presentation/pages/login/widgets/password_field.dart';
import 'package:weather_app/presentation/pages/login/widgets/submit_button.dart';

class LoginPage extends StatefulWidget {
  static const route = "/login";
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Logo(),
              SizedBox(
                height: 30.h,
              ),
              SizedBox(
                width: 120.w,
                height: 120.w,
                child: Image.asset(
                  Assets.imagesSun,
                  fit: BoxFit.cover,
                  width: 250.w,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Center(
                child: FormBuilder(
                  key: _loginKey,
                  child: Column(
                    children: [
                      const EmailField(),
                      const PasswordField(),
                      SubmitButton(onPressed: () {
                        if (_loginKey.currentState!.saveAndValidate()) {
                          final data = _loginKey.currentState?.value;
                          context.read<SignInBloc>().add(
                                OnSubmitSignIn(
                                  signInDto: SignInDto.fromMap(data!),
                                ),
                              );
                        }
                      })
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
