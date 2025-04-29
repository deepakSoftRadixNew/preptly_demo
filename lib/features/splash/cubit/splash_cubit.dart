import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'splash_state.dart';

/// SplashCubit manages the state and logic for the splash screen
@injectable
class SplashCubit extends Cubit<SplashState> {
  // Animation controller
  late AnimationController _animationController;
  late Animation<double> _animation;

  /// Creates a SplashCubit with initial state
  SplashCubit() : super(const SplashState());

  /// Initializes the animation and navigation timing
  void initialize(TickerProvider vsync) {
    // Setup animation
    _animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 1500),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    // Update state to animating
    emit(state.copyWith(status: SplashStatus.animating));

    // Listen to animation updates
    _animation.addListener(_onAnimationChanged);
    _animation.addStatusListener(_onAnimationStatusChanged);

    // Start animation
    _animationController.forward();

    // Schedule navigation
    _scheduleNavigation();
  }

  void _onAnimationChanged() {
    emit(state.copyWith(animationValue: _animation.value));
  }

  void _onAnimationStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      emit(state.copyWith(status: SplashStatus.animationComplete));
    }
  }

  void _scheduleNavigation() async {
    await Future.delayed(const Duration(seconds: 3));

    // Only proceed if we haven't been closed
    if (isClosed) return;

    emit(state.copyWith(status: SplashStatus.navigating));
  }

  @override
  Future<void> close() {
    _animationController.dispose();
    return super.close();
  }
}
