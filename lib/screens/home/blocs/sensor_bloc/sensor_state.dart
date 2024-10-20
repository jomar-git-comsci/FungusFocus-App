
import 'package:equatable/equatable.dart';

// abstract class WeatherState extends Equatable {
//   const WeatherState();

//   @override
//   List<Object?> get props => [];
// }

// class WeatherLoading extends WeatherState {}

// class WeatherLoaded extends WeatherState {
//   final Map<String, dynamic> weatherData;

//   const WeatherLoaded(this.weatherData);

//   @override
//   List<Object?> get props => [weatherData];
// }

// class WeatherError extends WeatherState {
//   final String message;

//   const WeatherError(this.message);

//   @override
//   List<Object?> get props => [message];
// }

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