import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:weather_app/core/dependencies/injection.dart';
import 'package:weather_app/presentation/blocs/blocs/auth/auth/auth_bloc.dart';
import 'package:weather_app/presentation/blocs/blocs/auth/sign_in/sign_in_bloc.dart';
import 'package:weather_app/presentation/blocs/weather/weather_bloc.dart';
import 'package:weather_app/presentation/pages/home/home_page.dart';
import 'package:weather_app/presentation/pages/login/login_page.dart';
import 'package:weather_app/presentation/routes/app_routes.dart';
import 'package:weather_app/presentation/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializer();
  runApp(const SncfWeather());
}

class SncfWeather extends StatefulWidget {
  const SncfWeather({Key? key}) : super(key: key);

  @override
  State<SncfWeather> createState() => _SncfWeatherState();
}

class _SncfWeatherState extends State<SncfWeather> {
  @override
  void initState() {
    appThemes.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthBloc>()
            ..add(
              IsAuthenticatedEvent(),
            ),
        ),
        BlocProvider<SignInBloc>(create: (context) => getIt<SignInBloc>()),
        BlocProvider<WeatherBloc>(create: (context) => getIt<WeatherBloc>())
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: appThemes.themeMode,
            localizationsDelegates: const [
              FormBuilderLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            home: child,
            builder: EasyLoading.init(),
            debugShowCheckedModeBanner: false,
            routes: AppRoutes.routes,
          );
        },
        child: MultiBlocListener(
          listeners: [
            BlocListener<SignInBloc, SignInState>(listener: (context, state) {
              if (state.status.isLoading) {
                EasyLoading.show(status: "Loading...");
              }
              if (state.status.isFailure) {
                EasyLoading.showError("${state.failure?.message}",
                    duration: const Duration(seconds: 2));
              }

              if (state.user != null) {
                EasyLoading.dismiss();
                context.read<AuthBloc>().add(IsAuthenticatedEvent());
              }
            })
          ],
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state.status.isLoading) {
                EasyLoading.show(status: "Loading");
                return const SizedBox();
              }
              if (state.isAuth) {
                EasyLoading.dismiss();
                return const HomePage();
              } else {
                EasyLoading.dismiss();
                return const LoginPage();
              }
            },
          ),
        ),
      ),
    );
  }
}
