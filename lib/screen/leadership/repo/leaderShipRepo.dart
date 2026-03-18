import 'dart:io';


import '../../../core/constants/api_constants.dart';
import '../../../core/exceptions/app_exceptions.dart';
import '../../../core/network/api_service.dart';
import '../../../core/network/network_utils.dart';
import '../../../core/services/secure_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../model/leaderShipModel.dart';



class LeaderShipRepo {
  final ApiService _api = ApiService();

  Future<LeaderShipModel> getLeaderShip(BuildContext context) async {
    try {
      final response = await _api.get(ApiConstants.leadershipChain,requiresAuth: true);
      return LeaderShipModel.fromJson(response);
    } on DioException catch (e) {
      if (e.error is NoInternetException) {
        showNoInternetScreen(context, onRetry: () => getLeaderShip(context));
        throw NoInternetException();
      } else if (e.error is ServerException) {
        showServerErrorScreen(context, onRetry: () => getLeaderShip(context));
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
