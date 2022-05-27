import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:my_weather/features/forcast/presentation/bloc/opacity_cubit.dart';

import '../bloc/forcast_bloc.dart';
import '../widgets/background_color.dart';
import '../widgets/error_body.dart';
import '../widgets/forcast_by_day_view.dart';
import '../widgets/forcast_by_hour_view.dart';
import '../widgets/info_current_weather.dart';
import '../widgets/main_temp.dart';
import 'search_view.dart';

List<String> titles = [
  'Sunrise',
  'Sunset',
  'Real feal',
  'Humidity',
  'Chance of rain',
  'Pressure',
  'Wind Speed',
  'Uv index',
];

class MyWeatherAndForcast extends StatefulWidget {
  const MyWeatherAndForcast({Key? key}) : super(key: key);

  @override
  State<MyWeatherAndForcast> createState() => _MyWeatherAndForcastState();
}

class _MyWeatherAndForcastState extends State<MyWeatherAndForcast> {
  final ScrollController _scrollController = ScrollController();
  final widgetKey = GlobalKey();
  late Offset widgetOffset;
  late double _currentPosition;

  @override
  void initState() {
    _scrollController.addListener(_setOffset);
    BlocProvider.of<ForcastBloc>(context)
        .add(GetForcastByCurrentLocationEvent());
    super.initState();
  }

  _setOffset() {
    RenderBox textFieldRenderBox =
        widgetKey.currentContext!.findRenderObject() as RenderBox;
    widgetOffset = textFieldRenderBox.localToGlobal(Offset.zero);
    _currentPosition = widgetOffset.dy;
    OpacityCubit.get(context).changeOpacity(widgetOffset, _currentPosition);
  }

  @override
  dispose() {
    _scrollController.removeListener(_setOffset);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForcastBloc, ForcastState>(
      builder: (context, state) {
        if (state is ForcastEmpty || state is ForcastLoading) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
              child: Lottie.asset('assets/json/day_and_night.json'),
            ),
          );
        } else if (state is ForcastError) {
          return const ErrorBody();
        } else if (state is ForcastLoaded) {
          return Stack(
            children: [
              BackgroundColor(
                sunrise: state.forcast.currentForcast.sunrise,
                sunset: state.forcast.currentForcast.sunset,
                homeCtx: context,
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  systemOverlayStyle: const SystemUiOverlayStyle(
                    systemNavigationBarColor: Color(0xFF000000),
                    systemNavigationBarIconBrightness: Brightness.light,
                    systemNavigationBarDividerColor: null,
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.light,
                    statusBarBrightness: Brightness.dark,
                    systemNavigationBarContrastEnforced: true,
                  ),
                  elevation: 0.0,
                  leading: IconButton(
                    onPressed: () {
                      BlocProvider.of<ForcastBloc>(context)
                          .add(GetForcastByCurrentLocationEvent());
                    },
                    icon: const Icon(Icons.location_on, color: Colors.white),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const SearchView(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.search, color: Colors.white),
                    ),
                  ],
                  title: const Text(
                    '',
                    style: TextStyle(color: Colors.white),
                  ),
                  centerTitle: true,
                ),
                body: state.forcast.message.isNotEmpty
                    ? const ErrorBody()
                    : CustomScrollView(
                        controller: _scrollController,
                        slivers: [
                          SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      MainTemperature(
                                        widgetKey: widgetKey,
                                        mainTitle: state
                                            .forcast.currentForcast.mainTitle,
                                        temp: state.forcast.currentForcast.temp,
                                      ),
                                      SizedBox(
                                        height: 200,
                                        child: ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: 5,
                                          itemBuilder: (ctx, i) {
                                            return ForcastByDayView(
                                              dailyForcast:
                                                  state.forcast.dailyForcast[i],
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 20.0),
                                      const FiveDayForcastButton(),
                                      const SizedBox(height: 100.0),
                                      SizedBox(
                                        height: 120.0,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: state.forcast.hourlyForcast
                                              .map((e) => ForcastByHourView(
                                                    hourlyForcast: e,
                                                  ))
                                              .toList(),
                                        ),
                                      ),
                                      const SizedBox(height: 20.0),
                                      Container(
                                        height: 300.0,
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                101, 216, 216, 216),
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InfoCurrentWeather(
                                                leftTitle: titles[0],
                                                leftSubTitle:
                                                    DateFormat('hh:mm').format(
                                                  DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                          state
                                                                  .forcast
                                                                  .currentForcast
                                                                  .sunrise *
                                                              1000),
                                                ),
                                                rightTitle: titles[1],
                                                rightSubTitle:
                                                    DateFormat('hh:mm').format(
                                                  DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                          state
                                                                  .forcast
                                                                  .currentForcast
                                                                  .sunset *
                                                              1000),
                                                ),
                                              ),
                                              InfoCurrentWeather(
                                                leftTitle: titles[2],
                                                leftSubTitle:
                                                    '${state.forcast.currentForcast.feelsLike}',
                                                rightTitle: titles[3],
                                                rightSubTitle:
                                                    '${state.forcast.currentForcast.humidity}%',
                                              ),
                                              InfoCurrentWeather(
                                                leftTitle: titles[4],
                                                leftSubTitle: '0%',
                                                rightTitle: titles[5],
                                                rightSubTitle:
                                                    '${state.forcast.currentForcast.pressure}mbar',
                                              ),
                                              InfoCurrentWeather(
                                                leftTitle: titles[6],
                                                leftSubTitle:
                                                    '${state.forcast.currentForcast.windSpeed}km/h',
                                                rightTitle: titles[7],
                                                rightSubTitle:
                                                    '${state.forcast.currentForcast.uvi}',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}

class FiveDayForcastButton extends StatelessWidget {
  const FiveDayForcastButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(101, 216, 216, 216),
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: const Center(
        child: Text(
          '5-day forcast',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
