import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_weather/features/forcast/presentation/bloc/opacity_cubit.dart';
import 'package:my_weather/features/forcast/presentation/bloc/opacity_states.dart';

import 'temp_view.dart';

class MainTemperature extends StatefulWidget {
  const MainTemperature({
    Key? key,
    required this.widgetKey,
    required this.temp,
    required this.mainTitle,
  }) : super(key: key);

  final GlobalKey<State<StatefulWidget>> widgetKey;
  final int temp;
  final String mainTitle;

  @override
  State<MainTemperature> createState() => _MainTemperatureState();
}

class _MainTemperatureState extends State<MainTemperature> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OpacityCubit, OpacityStates>(
      builder: (context, states) {
        return AnimatedOpacity(
          key: widget.widgetKey,
          duration: const Duration(milliseconds: 1),
          opacity: states is ChangeOpacityStates ? states.opacity : 1,
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 3 + 30,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TemperatureInCelsius(
                    temp: widget.temp,
                    tempSize: 130.0,
                    showC: true,
                    oSize: 11.0,
                    cSize: 16.0,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    widget.mainTitle,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
