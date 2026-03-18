import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/api_constants.dart';


class SplashRepo {
  Future<bool> isOnboardingCompleted() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool(ApiConstants.onboardingComplete) ?? false;
  }

  Future<bool> isUserLoggedIn() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(ApiConstants.token) != null;
  }

  Future<void> mockLoading() async {
    await Future.delayed(const Duration(milliseconds: 800));
  }
}
