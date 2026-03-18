import 'dart:io';


import '../../../core/constants/api_constants.dart';
import '../../../core/exceptions/app_exceptions.dart';
import '../../../core/network/api_service.dart';
import '../../../core/network/network_utils.dart';
import '../../../core/services/secure_storage_service.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../model/getProfileAssociationModel.dart';
import '../model/getProfileMemberModel.dart';
import '../model/updateProfileAssociationModel.dart';



class ProfileRepo {
  final ApiService _api = ApiService();

  Future<GetProfileAssociationModel> getProfileAssociation(BuildContext context) async {
    final response = await _api.get(ApiConstants.profileEndpoint,requiresAuth: true);
    return GetProfileAssociationModel.fromJson(response);
    try {

    } on DioException catch (e) {
      if (e.error is NoInternetException) {
        showNoInternetScreen(context, onRetry: () => getProfileAssociation(context));
        throw NoInternetException();
      } else if (e.error is ServerException) {
        showServerErrorScreen(context, onRetry: () => getProfileAssociation(context));
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
  }  Future<GetProfileMemberModel> getProfileMember(BuildContext context) async {
    try {
      final response = await _api.get(ApiConstants.profileEndpoint);
      return GetProfileMemberModel.fromJson(response);
    } on DioException catch (e) {
      if (e.error is NoInternetException) {
        showNoInternetScreen(context, onRetry: () => getProfileMember(context));
        throw NoInternetException();
      } else if (e.error is ServerException) {
        showServerErrorScreen(context, onRetry: () => getProfileMember(context));
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



  Future<AssociationUpdateModel> associationUpdateProfile({
    required BuildContext context,
    required String associationName,
    required String govtLegalRegistrationNumber,
    required String yearFormation,
    required String fullAddress,
    required String city,
    required String selectState,
    required String pin,
    required String presidentSecretary,
    // required String mobile,
    required String email,
    required String countryCode,
    required String registrationCertificateType,
    required String verifiedBy,
    required String verifiedAt,
    required File? profileImage,
    required File? registrationCertificateImage,
  }) async {
    try {
      final formData = FormData.fromMap({
        "associationName": associationName,
        "governmentRegistrationNumber": govtLegalRegistrationNumber,
        "yearOfFormation": yearFormation,
        "fullAddress": fullAddress,
        "city": city,
        "state": selectState,
        "pinCode": pin,
        "presidentOrSecretary": presidentSecretary,
        "countryCode": countryCode,
        // "phoneNumber": mobile,

        "email": email,
        "registrationCertificateType": registrationCertificateType,
        "verifiedBy": verifiedBy,
        "verifiedAt": verifiedAt,









        if (profileImage != null)
          "profileImage": await MultipartFile.fromFile(
            profileImage.path,
            filename: profileImage.path.split('/').last,
          ),
        if (registrationCertificateImage != null)
          "registrationDocument": await MultipartFile.fromFile(
            registrationCertificateImage.path,
            filename: registrationCertificateImage.path.split('/').last,
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
      final response = await _api.putMultipart(
          ApiConstants.updateAssociation,
          data: formData,
          isMultipart: true, // 👈 IMPORTANT
          requiresAuth: true


      );

      return AssociationUpdateModel.fromJson(response);
    } on DioException catch (e) {
      if (e.error is NoInternetException) {
        showNoInternetScreen(
          context,
          onRetry:
              () => associationUpdateProfile(
              context: context,
              associationName: associationName,
              govtLegalRegistrationNumber: govtLegalRegistrationNumber,
              yearFormation: yearFormation,
              fullAddress: fullAddress,
              city: city,
              selectState: selectState,
              pin: pin,
              presidentSecretary: presidentSecretary,
              // mobile: mobile,
              email: email,
              registrationCertificateType: registrationCertificateType,

              verifiedBy: verifiedBy,
              verifiedAt: verifiedAt,
              registrationCertificateImage: registrationCertificateImage,
              profileImage: profileImage,
              countryCode: countryCode
          ),
        );
        throw NoInternetException();
      } else if (e.error is ServerException) {
        showServerErrorScreen(
          context,
          onRetry:
              () => associationUpdateProfile(
              context: context,
              associationName: associationName,
              govtLegalRegistrationNumber: govtLegalRegistrationNumber,
              yearFormation: yearFormation,
              fullAddress: fullAddress,
              city: city,
              selectState: selectState,
              pin: pin,
              presidentSecretary: presidentSecretary,
              // mobile: mobile,
              email: email,
              registrationCertificateType: registrationCertificateType,

              verifiedBy: verifiedBy,
              verifiedAt: verifiedAt,
              registrationCertificateImage: registrationCertificateImage,
              profileImage: profileImage,
              countryCode: countryCode
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
