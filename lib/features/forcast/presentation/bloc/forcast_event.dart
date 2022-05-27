part of 'forcast_bloc.dart';

abstract class ForcastEvent extends Equatable {
  const ForcastEvent();

  @override
  List<Object> get props => [];
}

class GetForcastByCurrentLocationEvent extends ForcastEvent {}

class GetForcastByCityNameEvent extends ForcastEvent {
  final String cityName;
  const GetForcastByCityNameEvent(this.cityName);
}
