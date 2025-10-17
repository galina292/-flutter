abstract class CosmicSpeedState {}

class CosmicSpeedInitial extends CosmicSpeedState {}

class CosmicSpeedLoading extends CosmicSpeedState {}

class CosmicSpeedSuccess extends CosmicSpeedState {
  final double velocity;
  CosmicSpeedSuccess(this.velocity);
}

class CosmicSpeedError extends CosmicSpeedState {
  final String message;
  CosmicSpeedError(this.message);
}