import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungus_focus/app.dart';
import 'package:fungus_focus/simple_bloc_observer.dart';
import 'package:user_repository/user_repository.dart';
import 'dart:developer' as developer;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();

  runApp(MyApp(FirebaseUserRepo()));
}