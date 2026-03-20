import 'dart:io';


import '../../../core/constants/api_constants.dart';
import '../../../core/exceptions/app_exceptions.dart';
import '../../../core/network/api_service.dart';
import '../../../core/network/network_utils.dart';
import '../../../core/services/secure_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../auth/register/model/memberRegisterModel.dart';
import '../model/leaderShipModel.dart';
import '../model/postLeaderShipModel.dart';



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

  Future<PostLeaderShipModel> postLeaderShipApi({
    required BuildContext context,
    required String name,
    required String designation ,

    required File? profileImg ,
  }) async {
    try {
      final formData = FormData.fromMap({
        "name": name,
        "designation": designation ,//  enum: ["President", "Vice-President", "Secretary", "Treasurer"],



        if (profileImg != null)
          "profileImg": await MultipartFile.fromFile(
            profileImg.path,
            filename: profileImg.path.split('/').last,
          ),
      });
      // 👇 BODY PRINT HERE
      debugPrint("========== PATCH BODY ==========");
      for (var field in formData.fields) {
        debugPrint("${field.key} : ${field.value}");
      }
      for (var file in formData.files) {
        debugPrint("${file.key} : ${file.value.filename}");
      }
      debugPrint("================================");
      final response = await _api.postMultipart(
        ApiConstants.leadership,
        data: formData,
        isMultipart: true, // 👈 IMPORTANT
        requiresAuth: true
      );

      return PostLeaderShipModel.fromJson(response);
    } on DioException catch (e) {
      if (e.error is NoInternetException) {
        showNoInternetScreen(
          context,
          onRetry:
              () => postLeaderShipApi(
            context: context,
            name: name,
            profileImg: profileImg,
            designation: designation,



          ),
        );
        throw NoInternetException();
      } else if (e.error is ServerException) {
        showServerErrorScreen(
          context,
          onRetry:
              () => postLeaderShipApi(
                context: context,
                name: name,
                profileImg: profileImg,
                designation: designation,
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
}
