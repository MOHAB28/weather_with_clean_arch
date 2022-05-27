import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_weather/core/network/network_info.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/forcast_entities.dart';
import 'temp_view.dart';

const Map<int, String> weekdays = {
  1: "Mon",
  2: "Tue",
  3: "Wed",
  4: "Thu",
  5: "Fri",
  6: "Sat",
  7: "Sun"
};

class ForcastByDayView extends StatelessWidget {
  final DailyForcast dailyForcast;
  const ForcastByDayView({
    Key? key,
    required this.dailyForcast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 40.0,
          width: 40.0,
          child: FutureBuilder<bool>(
            future: sl<NetworkInfo>().isConnected,
            builder: (context, snapshot) {
              return snapshot.data == true
                  ? SizedBox(
                      child: Image(
                        image: NetworkImage(
                          'http://openweathermap.org/img/w/${dailyForcast.icon}.png',
                        ),
                      ),
                    )
                  : const SizedBox();
            },
          ),
        ),
        Row(
          children: [
            Text(
              DateFormat('EEE').format(DateTime.now()) ==
                      DateFormat('EEE').format(
                        DateTime.fromMillisecondsSinceEpoch(
                          dailyForcast.dateTime * 1000,
                        ),
                      )
                  ? 'Today'
                  : '${weekdays[DateTime.fromMillisecondsSinceEpoch(dailyForcast.dateTime * 1000).weekday]}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(width: 2.0),
            Container(
              width: 2.0,
              height: 2.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 2.0),
            Text(
              dailyForcast.mainTitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            TemperatureInCelsius(
              temp: dailyForcast.mornTemp,
              tempSize: 20.0,
              showC: false,
              paddingTop: 0.0,
              oSize: 10.0,
            ),
            const SizedBox(width: 3.0),
            const Text(
              '/',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(width: 3.0),
            TemperatureInCelsius(
              temp: dailyForcast.nightTemp,
              tempSize: 20.0,
              showC: false,
              paddingTop: 0.0,
              oSize: 10.0,
            ),
          ],
        ),
      ],
    );
  }
}
