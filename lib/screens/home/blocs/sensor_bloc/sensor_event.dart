
import 'package:equatable/equatable.dart';

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
