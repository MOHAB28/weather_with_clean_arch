import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'opacity_states.dart';

class OpacityCubit extends Cubit<OpacityStates> {
  OpacityCubit() : super(InitialState());
  static OpacityCubit get(context) => BlocProvider.of(context);

  double _opacity = 1;
  double get opacity => _opacity;
  void changeOpacity(Offset widgetOffset, double currentPosition) {
    if (100 > currentPosition && currentPosition > 1) {
      _opacity = currentPosition / 100;
    } else if (currentPosition > 100 && _opacity != 1) {
      _opacity = 1;
    } else if (currentPosition < 0 && _opacity != 0) {
      _opacity = 0;
    }
    emit(ChangeOpacityStates(_opacity));
  }
}
