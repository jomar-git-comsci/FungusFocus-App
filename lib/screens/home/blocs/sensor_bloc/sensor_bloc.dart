import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:developer' as developer;
import 'sensor_event.dart';
import 'sensor_state.dart';


class SensorBloc extends Bloc<SensorEvent, SensorState> {
  final DatabaseReference _weatherRef = FirebaseDatabase.instance.ref('Weather');
  final DatabaseReference _airQualityRef = FirebaseDatabase.instance.ref('AirQuality');
  final DatabaseReference _waterLevelRef = FirebaseDatabase.instance.ref('WaterLevel');

  SensorBloc() : super(SensorLoading()) {
    on<SensorDataLoadedEvent>(_onSensorDataLoaded);
    on<SensorErrorEvent>(_onSensorError);

    _initSensorListeners();
  }
  

  void _initSensorListeners() {
  _weatherRef.onValue.listen((DatabaseEvent event) async {
    try {
      final data = event.snapshot.value;
      developer.log("Weather data received: $data"); // Debug log
      final weatherData = (data is Map<Object?, Object?>) 
        ? _convertToMapStringDynamic(data) 
        : <String, dynamic>{};
      developer.log("Converted weather data: $weatherData"); // Debug log
      _fetchAirQualityAndWaterLevel(weatherData);
    } catch (e) {
      developer.log("Error in weather listener: $e"); // Debug log
      add(SensorErrorEvent("Error fetching weather data: $e"));
    }
  });
}

  Future<void> _fetchAirQualityAndWaterLevel(Map<String, dynamic> weatherData) async {
    try {
      final airQualitySnapshot = await _airQualityRef.get();
      final airQualityData = airQualitySnapshot.value;
      final airQuality = _processAirQualityData(airQualityData);

      final waterLevelSnapshot = await _waterLevelRef.get();
      final waterLevelData = waterLevelSnapshot.value;
      final waterLevel = _processWaterLevelData(waterLevelData);

      add(SensorDataLoadedEvent(
        weatherData: weatherData,
        airQuality: airQuality,
        waterLevel: waterLevel,
      ));
    } catch (e) {
      add(SensorErrorEvent("Error fetching sensor data: $e"));
    }
  }

  Future<void> _onSensorDataLoaded(SensorDataLoadedEvent event, Emitter<SensorState> emit) async {
    emit(SensorLoaded({
    'Weather': {
        'Humid': event.weatherData['Humid']?.toString(),
        'Temp': event.weatherData['Temp']?.toString(),
      },
      'AirQuality': {'Status': event.airQuality},
      'WaterLevel': {'Status': event.waterLevel},
    }));
  }

  Future<void> _onSensorError(SensorErrorEvent event, Emitter<SensorState> emit) async {
    emit(SensorError(event.message));
  }

  Map<String, dynamic> _convertToMapStringDynamic(Map<Object?, Object?> data) {
    return data.map((key, value) {
      final keyString = key.toString();
      if (value is Map) {
        return MapEntry(keyString, _convertToMapStringDynamic(value as Map<Object?, Object?>));
      }
      return MapEntry(keyString, value);
    });
  }

  String _processAirQualityData(dynamic data) {
    if (data is Map) {
      return data['Status']?.toString() ?? 'Unknown';
    }
    return data?.toString() ?? 'Unknown';
  }

  String _processWaterLevelData(dynamic data) {
    if (data is Map) {
      return data['Status']?.toString() ?? 'Unknown';
    }
    return data?.toString() ?? 'Unknown';
  }
}