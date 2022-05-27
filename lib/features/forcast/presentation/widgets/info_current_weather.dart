import 'package:flutter/material.dart';

import 'curent_weather_info.dart';

class InfoCurrentWeather extends StatelessWidget {
  final String leftTitle;
  final String leftSubTitle;
  final String rightTitle;
  final String rightSubTitle;
  const InfoCurrentWeather({
    Key? key,
    required this.leftSubTitle,
    required this.leftTitle,
    required this.rightSubTitle,
    required this.rightTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceAround,
      children: [
        CurrentWeatherInfoWidget(
          title: leftTitle,
          subtitle: leftSubTitle,
        ),
        CurrentWeatherInfoWidget(
          title: rightTitle,
          subtitle: rightSubTitle,
        ),
      ],
    );
  }
}
