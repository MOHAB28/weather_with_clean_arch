import 'package:flutter/material.dart';




class CurrentWeatherInfoWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const CurrentWeatherInfoWidget({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      width: 120,
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color.fromARGB(255, 176, 175, 175),
              fontSize: 16.0,
            ),
          ),
          SizedBox(
            height: 20.0,
            child: Text(
              subtitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
