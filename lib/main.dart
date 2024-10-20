import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungus_focus/app.dart';
import 'package:fungus_focus/simple_bloc_observer.dart';
import 'package:user_repository/user_repository.dart';
import 'dart:developer' as developer;

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
  
//   try {
//     await Firebase.initializeApp();
//     developer.log('Firebase initialized successfully', name: 'main');
//   } catch (e) {
//     developer.log('Error initializing Firebase: $e', name: 'main', error: e);
//     return;
//   }

//   Bloc.observer = SimpleBlocObserver();

//   final userRepository = FirebaseUserRepo();
  
//   runApp(MyApp(userRepository));
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();

  runApp(MyApp(FirebaseUserRepo()));
}