abstract class OpacityStates {}

class InitialState extends OpacityStates {}

class ChangeOpacityStates extends OpacityStates {
  final double opacity;
  ChangeOpacityStates(this.opacity);
}
