import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/forcast/presentation/bloc/forcast_bloc.dart';
import 'features/forcast/presentation/bloc/opacity_cubit.dart';
import 'features/forcast/presentation/pages/weather.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((_) => sl<ForcastBloc>())),
        BlocProvider(create: ((_) => OpacityCubit())),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(),
        home:  MyWeatherAndForcast(),
      ),
    );
  }
}
