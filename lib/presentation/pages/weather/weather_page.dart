import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/utils/extensions/string_extension.dart';
import 'package:weather_app/generated/assets.dart';
import 'package:weather_app/presentation/blocs/weather/weather_bloc.dart';

class WeatherPage extends StatelessWidget {
  static const route = "/WeatherPage";
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
        if (state.status.isLoading) {
          return const SizedBox(child: Text("Loading"));
        }
        return ListView.builder(
            itemCount: state.weathers.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.asset(Assets.imagesSun),
                title: Text(
                  state.weathers[index].dtTxt.toDateTime(),
                  style: textTheme.bodyText2,
                ),
                subtitle: Row(
                  children: [
                    Text(
                      "${state.weathers[index].main.temp}°C",
                      style: textTheme.bodyText2,
                    ),
                    Text(
                      " Min: ${state.weathers[index].main.tempMin}°C",
                      style: textTheme.bodyText2,
                    ),
                  ],
                ),
              );
            });
      }),
    );
  }
}
