import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/secure_storage_service.dart';

import 'splash_event.dart';
import 'splash_state.dart';
import '../repo/splash_repo.dart';


class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final SplashRepo repo;

  SplashBloc(this.repo) : super(SplashInitial()) {
    on<InitAppEvent>((event, emit) async {
      emit(SplashLoading());

      await Future.delayed( Duration(milliseconds: 1));

      final token = await SecureStorageService.getToken();

      print("App token is >>>>>>>>$token");

      if (token != null && token.isNotEmpty) {

        return;
      }

      /// fallback
      final onboardingDone = await repo.isOnboardingCompleted();
      final loggedIn = await repo.isUserLoggedIn();
      emit(SplashNavigateToLogin());


    });

  }
}
