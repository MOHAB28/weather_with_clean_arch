import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/network/network_info.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/forcast_entities.dart';
import 'temp_view.dart';



class ForcastByHourView extends StatelessWidget {
  final HourlyForcast hourlyForcast;
  const ForcastByHourView({
    Key? key,
    required this.hourlyForcast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          DateFormat('hh').format(DateTime.now()) ==
                  DateFormat('hh').format(DateTime.fromMillisecondsSinceEpoch(
                      hourlyForcast.dateTime * 1000))
              ? 'Now'
              : DateFormat('hh:mm').format(DateTime.fromMillisecondsSinceEpoch(
                  hourlyForcast.dateTime * 1000)),
          style: const TextStyle(
            fontSize: 16.0,
            color:  Color.fromARGB(101, 216, 216, 216),
          ),
        ),
        const SizedBox(height: 5.0),
        TemperatureInCelsius(
          temp: hourlyForcast.temp,
          tempSize: 20.0,
          showC: false,
          paddingTop: 0.0,
          oSize: 10.0,
        ),
        SizedBox(
          height: 50.0,
          width: 50.0,
          child: FutureBuilder<bool>(
            future: sl<NetworkInfo>().isConnected,
            builder: (context, snapshot) {
              return snapshot.data == true
                  ? SizedBox(
                      child: Image(
                        image: NetworkImage(
                          'http://openweathermap.org/img/w/${hourlyForcast.icon}.png',
                        ),
                      ),
                    )
                  : const SizedBox();
            },
          ),
        ),
        Text(
          '${hourlyForcast.windSpeed}km/h',
          style:  TextStyle(
            fontSize: 16.0,
            color:  Colors.grey[200],
          ),
        ),
      ],
    );
  }
}
