import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/forcast_entities.dart';
import '../repositories/forcast_repository.dart';

class GetForcastByCurrentLocation extends UseCase<Forcast, NoParams> {
  final ForcastRepository repository;
  GetForcastByCurrentLocation(this.repository);

  @override
  Future<Either<Failure, Forcast>> call(NoParams params) async {
    return await repository.getForcastByCurrentLocation();
  }
}
