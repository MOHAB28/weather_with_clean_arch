import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/forcast_local_data_source.dart';
import '../datasources/forcast_remote_data_source.dart';
import '../../domain/entities/forcast_entities.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/forcast_repository.dart';

class ForcastRepositoryImpl implements ForcastRepository {
  final ForcastLocalDataSources localDataSources;
  final ForcastRemoteDataSources remoteDataSources;
  final NetworkInfo networkInfo;
  ForcastRepositoryImpl({
    required this.localDataSources,
    required this.networkInfo,
    required this.remoteDataSources,
  });
  @override
  Future<Either<Failure, Forcast>> getForcastByCurrentLocation() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteForcast =
            await remoteDataSources.getForcastByCurrentLocation();
        localDataSources.cacheForcast(remoteForcast);
        return Right(remoteForcast);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localForcast = await localDataSources.getLastForcast();
      
        return Right(localForcast);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Forcast>> getForcastByCityName(String cityName) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteForcast =
            await remoteDataSources.getForcastByCityName(cityName);
        localDataSources.cacheForcast(remoteForcast);
        return Right(remoteForcast);
      } on ServerException {
        throw Left(ServerFailure());
      }
    } else {
      try {
        final localForcast = await localDataSources.getLastForcast();
        return Right(localForcast);
      }on CacheException {
        throw Left(CacheFailure());
      }
    }
  }
}
