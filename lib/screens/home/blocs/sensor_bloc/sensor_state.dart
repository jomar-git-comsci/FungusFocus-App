
import 'package:equatable/equatable.dart';


abstract class SensorState extends Equatable {
  const SensorState();

  @override
  List<Object?> get props => [];
}

class SensorLoading extends SensorState {}

class SensorLoaded extends SensorState {
  final Map<String, dynamic> sensorData;

  const SensorLoaded(this.sensorData);

  @override
  List<Object?> get props => [sensorData];
}

class SensorError extends SensorState {
  final String message;

  const SensorError(this.message);

  @override
  List<Object?> get props => [message];
}