abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}



class SplashNavigateToLogin extends SplashState {}

class SplashNavigateToDashboard extends SplashState {
  final bool isAgent;
  final bool isUser;

  SplashNavigateToDashboard({
    required this.isAgent,
    required this.isUser,
  });
}
