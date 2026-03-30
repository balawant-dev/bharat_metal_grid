




import '../../../core/constants/api_constants.dart';
import '../../../core/exceptions/app_exceptions.dart';
import '../../../core/network/api_service.dart';
import '../../../core/network/network_utils.dart';
import '../../../core/services/secure_storage_service.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


import '../model/complaintResponseModel.dart';






class ComplaintRepo {
  final ApiService _api = ApiService();

  Future<ComplaintResponseModel> createComplaintApi({required BuildContext context,required String email,required String mobileNumber,required String remark}) async {
    try {
      final response = await _api.post(ApiConstants.complaintSupport,requiresAuth: true,data: {
        "email": email,
        "mobileNumber": mobileNumber,
        "remark": remark,
      });
      return ComplaintResponseModel.fromJson(response);
    } on DioException catch (e) {
      if (e.error is NoInternetException) {
        showNoInternetScreen(context, onRetry: () => createComplaintApi(context:context ,email: email,mobileNumber: mobileNumber,remark: remark));
        throw NoInternetException();
      } else if (e.error is ServerException) {
        showServerErrorScreen(context, onRetry: () => createComplaintApi(context:context ,email: email,mobileNumber: mobileNumber,remark: remark));
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
