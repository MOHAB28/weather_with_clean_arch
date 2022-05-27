import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/network_info.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'features/forcast/data/datasources/forcast_local_data_source.dart';
import 'features/forcast/data/datasources/forcast_remote_data_source.dart';
import 'features/forcast/data/repositories/repository_impl.dart';
import 'features/forcast/domain/repositories/forcast_repository.dart';
import 'features/forcast/domain/usecases/get_forcast_by_city_name.dart';
import 'features/forcast/domain/usecases/get_forcast_by_current_location.dart';
import 'features/forcast/presentation/bloc/forcast_bloc.dart';


final sl = GetIt.instance;

Future<void> init() async {
  //! Features - NumberTrivia

  sl.registerFactory(
    () => ForcastBloc(
      forcastByCityName: sl(),
      forcastByCurrentLocation: sl(),
    ),
  );
  // Use cases

  sl.registerLazySingleton(() => GetForcastByCurrentLocation(sl()));

  sl.registerLazySingleton(() => GetForcastByCityName(sl()));

  // Repository

  sl.registerLazySingleton<ForcastRepository>(
    () => ForcastRepositoryImpl(
      localDataSources: sl(),
      remoteDataSources: sl(),
      networkInfo: sl(),
    ),
  );
  // Data sources

  sl.registerLazySingleton<ForcastRemoteDataSources>(
    () => ForcastRemoteDataSourcesImpl(
      geolocator: sl(),
      client: sl(),
    ),
  );



    sl.registerLazySingleton<ForcastLocalDataSources>(
    () => ForcastLocalDataSourcesImpl(
      sl(),
    ),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  final geolocatorPlatform = GeolocatorPlatform.instance;
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => geolocatorPlatform);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
