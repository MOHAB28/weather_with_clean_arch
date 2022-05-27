part of 'forcast_bloc.dart';

abstract class ForcastState extends Equatable {
  const ForcastState();  

  @override
  List<Object> get props => [];
}
class ForcastEmpty extends ForcastState {}

class ForcastLoading extends ForcastState {}

class ForcastLoaded extends ForcastState {
  final Forcast forcast;

  const ForcastLoaded({required this.forcast});
}

class ForcastError extends ForcastState {
  final String message;

  const ForcastError({required this.message});
}