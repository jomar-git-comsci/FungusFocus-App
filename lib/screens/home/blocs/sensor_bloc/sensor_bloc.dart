import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:developer' as developer;
import 'sensor_event.dart';
import 'sensor_state.dart';

// class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
//   final DatabaseReference _weatherRef = FirebaseDatabase.instance.ref('Weather');

//   WeatherBloc() : super(WeatherLoading()) {
//     developer.log('WeatherBloc initialized', name: 'WeatherBloc');
//     on<WeatherLoadedEvent>(_onWeatherLoaded);
//     on<WeatherErrorEvent>(_onWeatherError);
//     _initWeatherListener();
//   }

//   void _initWeatherListener() {
//     developer.log('Initializing weather listener', name: 'WeatherBloc');
//     _weatherRef.onValue.listen(
//       (DatabaseEvent event) async {
//         try {
//           developer.log('Received database event', name: 'WeatherBloc');
//           final data = event.snapshot.value;
//           if (data != null && data is Map) {
//             final weatherData = Map<String, dynamic>.from(
//               data.map((key, value) => MapEntry(key.toString(), value))
//             );
//             developer.log('Weather data received: $weatherData', name: 'WeatherBloc');
//             add(WeatherLoadedEvent(weatherData));
//           } else {
//             developer.log('No weather data available or invalid format', name: 'WeatherBloc');
//             add(const WeatherErrorEvent("No data available or invalid format"));
//           }
//         } catch (e, stackTrace) {
//           developer.log('Error processing weather data: $e\n$stackTrace', name: 'WeatherBloc');
//           add(WeatherErrorEvent(e.toString()));
//         }
//       },
//       onError: (error) {
//         developer.log('Firebase listener error: $error', name: 'WeatherBloc');
//         add(WeatherErrorEvent(error.toString()));
//       },
//     );
//   }

//   Future<void> _onWeatherLoaded(WeatherLoadedEvent event, Emitter<WeatherState> emit) async {
//     developer.log('Emitting WeatherLoaded state', name: 'WeatherBloc');
//     emit(WeatherLoaded(event.weatherData));
//   }

//   Future<void> _onWeatherError(WeatherErrorEvent event, Emitter<WeatherState> emit) async {
//     developer.log('Emitting WeatherError state: ${event.message}', name: 'WeatherBloc');
//     emit(WeatherError(event.message));
//   }
// }

// class SensorBloc extends Bloc<SensorEvent, SensorState> {
//   final DatabaseReference _weatherRef = FirebaseDatabase.instance.ref('Weather');
//   final DatabaseReference _airQualityRef = FirebaseDatabase.instance.ref('AirQuality');
//   final DatabaseReference _waterLevelRef = FirebaseDatabase.instance.ref('WaterLevel');

//   SensorBloc() : super(SensorLoading()) {
//     on<SensorDataLoadedEvent>(_onSensorDataLoaded);
//     on<SensorErrorEvent>(_onSensorError);

//     _initSensorListeners();
//   }
  
// void _initSensorListeners() {
//   // Listening to the weather data
//   _weatherRef.onValue.listen((DatabaseEvent event) async {
//     try {
//       final data = event.snapshot.value;
//       // Safely cast to Map<String, dynamic> if possible
//       final weatherData = (data is Map<dynamic, dynamic>) ? _convertToMapStringDynamic(data) : <String, dynamic>{};
//       _fetchAirQualityAndWaterLevel(weatherData);  // This will now have the correct type
//     } catch (e) {
//       add(SensorErrorEvent("Error fetching weather data: $e"));
//     }
//   });
// }

//   Future<void> _fetchAirQualityAndWaterLevel(Map<String, dynamic> weatherData) async {
//     try {
//       // Fetch Air Quality Data
//       final airQualitySnapshot = await _airQualityRef.get();
//       final airQuality = airQualitySnapshot.value?.toString() ?? 'Unknown';

//       // Fetch Water Level Data
//       final waterLevelSnapshot = await _waterLevelRef.get();
//       final waterLevel = waterLevelSnapshot.value?.toString() ?? 'Unknown';

//       // Emit Loaded Event with all data
//       add(SensorDataLoadedEvent(
//         weatherData: weatherData,
//         airQuality: airQuality,
//         waterLevel: waterLevel,
//       ));
//     } catch (e) {
//       add(SensorErrorEvent("Error fetching sensor data: $e"));
//     }
//   }

//   Future<void> _onSensorDataLoaded(SensorDataLoadedEvent event, Emitter<SensorState> emit) async {
//     emit(SensorLoaded({
//       'Humid': event.weatherData['humidity'],
//       'Temp': event.weatherData['temperature'],
//       'AirQuality': event.airQuality,
//       'WaterLevel': event.waterLevel,
//     }));
//   }

//   Future<void> _onSensorError(SensorErrorEvent event, Emitter<SensorState> emit) async {
//     emit(SensorError(event.message));
//   }

//   // Utility function to convert Map<Object?, Object?> to Map<String, dynamic>
//   Map<String, dynamic> _convertToMapStringDynamic(Map data) {
//     return data.map((key, value) {
//       final keyString = key.toString(); // Ensure key is String
//       return MapEntry(keyString, value);
//     });
//   }
// }

class SensorBloc extends Bloc<SensorEvent, SensorState> {
  final DatabaseReference _weatherRef = FirebaseDatabase.instance.ref('Weather');
  final DatabaseReference _airQualityRef = FirebaseDatabase.instance.ref('AirQuality');
  final DatabaseReference _waterLevelRef = FirebaseDatabase.instance.ref('WaterLevel');

  SensorBloc() : super(SensorLoading()) {
    on<SensorDataLoadedEvent>(_onSensorDataLoaded);
    on<SensorErrorEvent>(_onSensorError);

    _initSensorListeners();
  }
  
  // void _initSensorListeners() {
  //   _weatherRef.onValue.listen((DatabaseEvent event) async {
  //     try {
  //       final data = event.snapshot.value;
  //       final weatherData = (data is Map<Object?, Object?>) 
  //         ? _convertToMapStringDynamic(data) 
  //         : <String, dynamic>{};
  //       _fetchAirQualityAndWaterLevel(weatherData);
  //     } catch (e) {
  //       add(SensorErrorEvent("Error fetching weather data: $e"));
  //     }
  //   });
  // }
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
    //   'Weather': event.weatherData,
    //   'AirQuality': {'Status': event.airQuality},
    //   'WaterLevel': {'Status': event.waterLevel},
    // }));
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