import 'package:equatable/equatable.dart';

/// Enum representing the various states of the splash screen
enum SplashStatus {
  /// Initial state when the splash screen loads
  initial,

  /// Animation is in progress
  animating,

  /// Animation has completed
  animationComplete,

  /// Ready to navigate to the next screen
  navigating,
}

/// State class for the SplashScreen
class SplashState extends Equatable {
  /// Current status of the splash screen
  final SplashStatus status;

  /// Value of the animation (0.0 to 1.0)
  final double animationValue;

  /// Creates a SplashState
  const SplashState({this.status = SplashStatus.initial, this.animationValue = 0.0});

  @override
  List<Object?> get props => [status, animationValue];

  /// Creates a copy of this state with the given fields replaced
  SplashState copyWith({SplashStatus? status, double? animationValue}) {
    return SplashState(
      status: status ?? this.status,
      animationValue: animationValue ?? this.animationValue,
    );
  }

  /// Checks if current status is animating
  bool get isAnimating => status == SplashStatus.animating;

  /// Checks if animation is complete
  bool get isAnimationComplete => status == SplashStatus.animationComplete;

  /// Checks if ready to navigate
  bool get isNavigating => status == SplashStatus.navigating;
}
