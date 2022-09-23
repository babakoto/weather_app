import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/generated/assets.dart';
import 'package:weather_app/presentation/blocs/blocs/auth/auth/auth_bloc.dart';
import 'package:weather_app/presentation/blocs/weather/weather_bloc.dart';
import 'package:weather_app/presentation/pages/weather/weather_page.dart';

class HomePage extends StatelessWidget {
  static const route = "/home";
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
              return Text("Bienvenue ${state.user?.firstName}");
            }),
            actions: [
              IconButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(OnLogOutEvent());
                  },
                  icon: const Icon(
                    Icons.power_settings_new,
                    color: Colors.white,
                  ))
            ]),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              ListTile(
                tileColor: Colors.white,
                title: const Text("Paris"),
                onTap: () {
                  context.read<WeatherBloc>().add(
                        const OnFetchWeather(city: "paris"),
                      );
                  Navigator.pushNamed(context, WeatherPage.route);
                },
                leading: Image.asset(Assets.imagesSun),
              ),
              const Divider(
                height: 2,
              ),
              ListTile(
                onTap: () {
                  context
                      .read<WeatherBloc>()
                      .add(const OnFetchWeather(city: "Rennes"));

                  Navigator.pushNamed(context, WeatherPage.route);
                },
                tileColor: Colors.white,
                title: const Text("Rennes"),
                leading: Image.asset(Assets.imagesSun),
              )
            ],
          ),
        ));
  }
}
