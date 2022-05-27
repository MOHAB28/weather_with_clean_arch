import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/forcast_entities.dart';

abstract class ForcastRepository {
  Future<Either<Failure,Forcast>> getForcastByCurrentLocation();
  Future<Either<Failure,Forcast>> getForcastByCityName(String cityName);
}