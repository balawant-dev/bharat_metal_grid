
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/exceptions/app_exceptions.dart';
import '../../../core/network/api_service.dart';
import '../../../core/network/network_utils.dart';
import '../../../core/services/secure_storage_service.dart';
import '../../settings/cms/model/settingsModel.dart';
import '../login/model/loginModel.dart';
import '../otp/model/verifyOtpModel.dart';
import '../register/model/registerModel.dart';
import '../role/model/selectRoleModel.dart';

class AuthRepo {
  final ApiService _api = ApiService();

  Future<LoginModel> sendOtp({
    required String phone,
    required BuildContext context,
  }) async {
    try {
      final response = await _api.post(
        ApiConstants.sendOtp,
        data: {'phoneNumber': phone},
        requiresAuth: false,
      );
      //   await SecureStorageService.saveToken(response['token']);
      return LoginModel.fromJson(response);
      //  return LoginModel.fromJson(response['user']);
    } on DioException catch (e) {
      if (e.error is NoInternetException) {
        showNoInternetScreen(
          context,
          onRetry: () => sendOtp(phone: phone, context: context),
        );
        throw NoInternetException();
      } else if (e.error is ServerException) {
        showServerErrorScreen(
          context,
          onRetry: () => sendOtp(phone: phone, context: context),
        );
        throw ServerException();
      } else if (e.error is UnauthorizedException) {
        await SecureStorageService.logout(context);
        throw UnauthorizedException();
      } else {
        rethrow;
      }
    } catch (e) {
      throw ApiException(0, e.toString());
    }
  }

  Future<RegisterModel> registerOtp({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String aadharNumber,
    required BuildContext context,
  }) async {
    try {
      final response = await _api.post(
        ApiConstants.agentSignUp,
        data: {
          "name": name,
          "email": email,
          "phone": phone,
          "address": address,
          "aadharNumber": aadharNumber,
        },
        requiresAuth: false,
      );
      //   await SecureStorageService.saveToken(response['token']);
      return RegisterModel.fromJson(response);
      //  return LoginModel.fromJson(response['user']);
    } on DioException catch (e) {
      if (e.error is NoInternetException) {
        showNoInternetScreen(
          context,
          onRetry:
              () => registerOtp(
                phone: phone,
                context: context,
                name: name,
                email: email,
                address: address,
                aadharNumber: aadharNumber,
              ),
        );
        throw NoInternetException();
      } else if (e.error is ServerException) {
        showServerErrorScreen(
          context,
          onRetry:
              () => registerOtp(
                phone: phone,
                context: context,
                aadharNumber: aadharNumber,
                address: address,
                email: email,
                name: name,
              ),
        );
        throw ServerException();
      } else if (e.error is UnauthorizedException) {
        await SecureStorageService.logout(context);
        throw UnauthorizedException();
      } else {
        rethrow;
      }
    } catch (e) {
      throw ApiException(0, e.toString());
    }
  }

  Future<VerifyOtpModel> verifyOtp({
    required String phone,
    required String otp,

    required BuildContext context,
  }) async {
    try {
      final response = await _api.post(
        ApiConstants.verifyOtp,
        data: {'phoneNumber': phone, "otp": otp,},
        requiresAuth: false,
      );
      // print("Store>>>>>>>>>>>>>>>>>>token ${response['token']}");
      // await SecureStorageService.saveToken(response['token']);
      // await SecureStorageService.saveIsAgent(response['data']["isAgent"]);
      // await SecureStorageService.saveIsUser(response['data']["isUser"]);
      return VerifyOtpModel.fromJson(response);
      //  return LoginModel.fromJson(response['user']);
    } on DioException catch (e) {
      if (e.error is NoInternetException) {
        showNoInternetScreen(
          context,
          onRetry: () => verifyOtp(phone: phone, otp: otp, context: context),
        );
        throw NoInternetException();
      } else if (e.error is ServerException) {
        showServerErrorScreen(
          context,
          onRetry: () => verifyOtp(phone: phone, otp: otp, context: context),
        );
        throw ServerException();
      } else if (e.error is UnauthorizedException) {
        await SecureStorageService.logout(context);
        throw UnauthorizedException();
      } else {
        rethrow;
      }
    } catch (e) {
      throw ApiException(0, e.toString());
    }
  }


  Future<SelectRoleModel> verifyRole({
    required String phone,
    required String userType,

    required BuildContext context,
  }) async {
    try {
      final response = await _api.post(
        ApiConstants.userType,
        data: {'phoneNumber': phone, "userType": userType,},
        requiresAuth: false,
      );
      // print("Store>>>>>>>>>>>>>>>>>>token ${response['token']}");
      // await SecureStorageService.saveToken(response['token']);
      // await SecureStorageService.saveIsAgent(response['data']["isAgent"]);
      // await SecureStorageService.saveIsUser(response['data']["isUser"]);
      return SelectRoleModel.fromJson(response);
      //  return LoginModel.fromJson(response['user']);
    } on DioException catch (e) {
      if (e.error is NoInternetException) {
        showNoInternetScreen(
          context,
          onRetry: () => verifyRole(phone: phone, userType: userType, context: context),
        );
        throw NoInternetException();
      } else if (e.error is ServerException) {
        showServerErrorScreen(
          context,
          onRetry: () => verifyRole(phone: phone, userType: userType, context: context),
        );
        throw ServerException();
      } else if (e.error is UnauthorizedException) {
        await SecureStorageService.logout(context);
        throw UnauthorizedException();
      } else {
        rethrow;
      }
    } catch (e) {
      throw ApiException(0, e.toString());
    }
  }

  Future<SettingResponseModel> getSettingsApi({

    required BuildContext context,
  }) async {
    try {
      final response = await _api.get(
        ApiConstants.settingData,

        requiresAuth: true,
      );

      return SettingResponseModel.fromJson(response);
      //  return LoginModel.fromJson(response['user']);
    } on DioException catch (e) {
      if (e.error is NoInternetException) {
        showNoInternetScreen(
          context,
          onRetry: () => getSettingsApi( context: context),
        );
        throw NoInternetException();
      } else if (e.error is ServerException) {
        showServerErrorScreen(
          context,
          onRetry: () => getSettingsApi( context: context),
        );
        throw ServerException();
      } else if (e.error is UnauthorizedException) {
        await SecureStorageService.logout(context);
        throw UnauthorizedException();
      } else {
        rethrow;
      }
    } catch (e) {
      throw ApiException(0, e.toString());
    }
  }
}
