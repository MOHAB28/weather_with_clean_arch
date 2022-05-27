import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BackgroundColor extends StatelessWidget {
  final int sunset;
  final int sunrise;
  final BuildContext homeCtx;
  const BackgroundColor({
    Key? key,
    required this.sunrise,
    required this.sunset,
    required this.homeCtx,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if ((int.parse(DateFormat('hh').format(DateTime.now()))) >=
        (int.parse(DateFormat('hh')
            .format(DateTime.fromMillisecondsSinceEpoch(sunset * 1000))))) {
      return Container(
        height: MediaQuery.of(homeCtx).size.height,
        width: MediaQuery.of(homeCtx).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.decal,
              colors: [
                Color(0xff3E434C),
                Color(0xff32373C),
                Color(0xff25292E),
                // Color.fromARGB(255, 61, 101, 194),
                // Color.fromARGB(255, 54, 91, 179),
                // Color(0xff3053A6),
              ]),
        ),
      );
    } else {
      return Container(
        height: MediaQuery.of(homeCtx).size.height,
        width: MediaQuery.of(homeCtx).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.decal,
              colors: [
                Color.fromARGB(255, 61, 101, 194),
                Color.fromARGB(255, 54, 91, 179),
                Color(0xff3053A6),
              ]),
        ),
      );
    }
  }
}
// if((int.parse(DateFormat('hh').format(DateTime.now()))) >= (int.parse(DateFormat('hh').format(DateTime.fromMillisecondsSinceEpoch(state.forcast.currentForcast.sunset * 1000))))) ...[
//                   Container(
//                 height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.width,
//                 decoration: const BoxDecoration(
//                   gradient:  
//                   LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       tileMode: TileMode.decal,
//                       colors: [
//                         Color(0xff3E434C),
//                         Color(0xff32373C),
//                         Color(0xff25292E),
//                         // Color.fromARGB(255, 61, 101, 194),
//                         // Color.fromARGB(255, 54, 91, 179),
//                         // Color(0xff3053A6),
//                       ]),
//                 ),
//               ),
//               ],
//               if((int.parse(DateFormat('hh').format(DateTime.now()))) >= (int.parse(DateFormat('hh').format(DateTime.fromMillisecondsSinceEpoch(state.forcast.currentForcast.sunrise * 1000))))
//               && (int.parse(DateFormat('hh').format(DateTime.now()))) < (int.parse(DateFormat('hh').format(DateTime.fromMillisecondsSinceEpoch(state.forcast.currentForcast.sunset * 1000))))) ...[
//                   Container(
//                 height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.width,
//                 decoration: const BoxDecoration(
//                   gradient:  
//                   LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       tileMode: TileMode.decal,
//                       colors: [
//                         Color.fromARGB(255, 61, 101, 194),
//                         Color.fromARGB(255, 54, 91, 179),
//                         Color(0xff3053A6),
//                       ]),
//                 ),
//               ),
//               ],