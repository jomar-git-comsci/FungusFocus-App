import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  late final StreamSubscription<MyUser?> _userSubscription;

  AuthenticationBloc({
    required this.userRepository
  }) : super(const AuthenticationState.unknown()) {
    on<AuthenticationStatusRequested>(_onAuthenticationStatusRequested);
    on<AuthenticationUserChanged>(_onAuthenticationUserChanged);

    _userSubscription = userRepository.user.listen((user) {
      add(AuthenticationUserChanged(user));
    });

    // Trigger initial authentication check
    add(AuthenticationStatusRequested());
  }

  Future<void> _onAuthenticationStatusRequested(
    AuthenticationStatusRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    final user = await userRepository.getCurrentUser();
    if (user != MyUser.empty) {
      emit(AuthenticationState.authenticated(user!));
    } else {
      emit(const AuthenticationState.unauthenticated());
    }
  }

  void _onAuthenticationUserChanged(
    AuthenticationUserChanged event,
    Emitter<AuthenticationState> emit,
  ) {
    if (event.user != MyUser.empty) {
      emit(AuthenticationState.authenticated(event.user!));
    } else {
      emit(const AuthenticationState.unauthenticated());
    }
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}