
import 'package:equatable/equatable.dart';

// abstract class WeatherEvent extends Equatable {
//   const WeatherEvent();

//   @override
//   List<Object?> get props => [];
// }

// class WeatherLoadedEvent extends WeatherEvent {
//   final Map<String, dynamic> weatherData;

//   const WeatherLoadedEvent(this.weatherData);

//   @override
//   List<Object?> get props => [weatherData];
// }

// class WeatherErrorEvent extends WeatherEvent {
//   final String message;

//   const WeatherErrorEvent(this.message);

//   @override
//   List<Object?> get props => [message];
// }

abstract class SensorEvent extends Equatable {
  const SensorEvent();

  @override
  List<Object?> get props => [];
}

class SensorDataLoadedEvent extends SensorEvent {
  final Map<String, dynamic> weatherData;
  final String airQuality;
  final String waterLevel;

  const SensorDataLoadedEvent({
    required this.weatherData,
    required this.airQuality,
    required this.waterLevel,
  });

  @override
  List<Object?> get props => [weatherData, airQuality, waterLevel];
}

class SensorErrorEvent extends SensorEvent {
  final String message;

  const SensorErrorEvent(this.message);

  @override
  List<Object?> get props => [message];
}
