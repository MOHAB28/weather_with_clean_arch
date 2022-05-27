import 'package:flutter/material.dart';

class TemperatureInCelsius extends StatelessWidget {
  final double tempSize;
  final double oSize;
  final double? cSize;
  final bool showC;
  final int temp;
  final Color tempcolor;
  final double paddingTop;
  const TemperatureInCelsius({
    Key? key,
    this.cSize,
    required this.temp,
    required this.oSize,
    required this.tempSize,
    required this.showC,
    this.paddingTop = 28.0,
    this.tempcolor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$temp',
          textAlign: TextAlign.end,
          style: TextStyle(
            fontSize: tempSize,
            color: tempcolor,
            fontWeight: FontWeight.w500,
          ),

        ),
        Padding(
          padding:  EdgeInsets.only(top: paddingTop),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'o',
                style: TextStyle(
                  fontSize: oSize,
                  color: tempcolor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (showC == true) ...[
                Text(
                  'C',
                  style: TextStyle(
                    color: tempcolor,
                    fontSize: cSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
