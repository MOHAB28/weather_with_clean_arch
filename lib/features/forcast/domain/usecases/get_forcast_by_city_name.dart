import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/forcast_entities.dart';
import '../repositories/forcast_repository.dart';

class GetForcastByCityName extends UseCase<Forcast, Params> {
  final ForcastRepository repository;
  GetForcastByCityName(this.repository);
  @override
  Future<Either<Failure, Forcast>> call(Params params) async {
    return await repository.getForcastByCityName(params.cityName);
  }
}


class Params {
  final String cityName;
  Params(this.cityName);
}
