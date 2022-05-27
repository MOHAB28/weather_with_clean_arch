import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/forcast_entities.dart';
import '../../domain/usecases/get_forcast_by_city_name.dart';
import '../../domain/usecases/get_forcast_by_current_location.dart';

part 'forcast_event.dart';
part 'forcast_state.dart';

const String serverFailureMessage = 'SERVER_ERROR';
const String cacheFailureMessage = 'CACHE_ERROR';

class ForcastBloc extends Bloc<ForcastEvent, ForcastState> {
  final GetForcastByCityName forcastByCityName;
  final GetForcastByCurrentLocation forcastByCurrentLocation;
  ForcastState get initialState => ForcastEmpty();
  ForcastBloc({
    required this.forcastByCityName,
    required this.forcastByCurrentLocation,
  }) : super(ForcastEmpty()) {
    on<ForcastEvent>((event, emit) {});
    on<GetForcastByCurrentLocationEvent>((event, emit) async {
      emit(ForcastLoading());
      final failureOrForcast = await forcastByCurrentLocation(NoParams());
      failureOrForcast.fold(
        (failure) async {
          emit(ForcastError(message: _mapFailureToMessage(failure)));
        },
        (forcast) async {
          emit(ForcastLoaded(forcast: forcast));
        },
      );
    });
    on<GetForcastByCityNameEvent>((event, emit) async {
      emit(ForcastLoading());
      final failureOrForcast = await forcastByCityName(Params(event.cityName));
      failureOrForcast.fold(
        (failure) async {
          emit(ForcastError(message: _mapFailureToMessage(failure)));
        },
        (forcast) async {
          emit(ForcastLoaded(forcast: forcast));
        },
      );
    });
  }
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return serverFailureMessage;
    case CacheFailure:
      return cacheFailureMessage;
    default:
      return 'Unexpected error';
  }
}
