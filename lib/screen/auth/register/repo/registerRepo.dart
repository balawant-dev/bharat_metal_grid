import 'dart:io';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/exceptions/app_exceptions.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/network/network_utils.dart';
import '../../../../core/services/secure_storage_service.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../model/associationRegistrationModel.dart';
import '../model/getAllAssociationModel.dart';
import '../model/memberRegisterModel.dart';
import '../model/organizationDetailsModel.dart';
import '../model/registerModel.dart';

class RegisterRepo {
  final ApiService _api = ApiService();

  Future<MemberRegisterBasicModel> memberRegistration({
    required BuildContext context,
    required String fullName,
    required String designation,
    required String email,
    required String phoneNumber,
    required String countryCode,
    required String gender,
    required String state,
    required String language,
    required String organizationType,
    required String organizationName,
    required String parentOrganizationName,
    required String postalAddress,
    required String dateIncorporation,
    required String contactNumber,
    required String organizationEmailId,
    required String natureOrganization,
    required String panNumber,
    required String gstNumber,
    required List selectAssociation,
    required File? profileImage,
  }) async {
    try {
      final formData = FormData.fromMap({
        "fullName": fullName,
        "gender": gender,
        "designation": designation,
        "countryCode": countryCode,
        "phoneNumber": phoneNumber,
        "email": email,
        "state": state,
        "preferredLanguage": language,
        "organizationType": organizationType,
        "organizationName": organizationName,
        "parentOrganizationName": parentOrganizationName,
        "postalAddress": postalAddress,
        "dateOfIncorporation": dateIncorporation,
        "contactNumber": contactNumber,
        "organizationEmailId": organizationEmailId,
        "natureOfOrganization": natureOrganization,
        "panNumber": panNumber,
        "gstNumber": gstNumber,
        "selectedAssociations": selectAssociation,

        if (profileImage != null)
          "profileImage": await MultipartFile.fromFile(
            profileImage.path,
            filename: profileImage.path.split('/').last,
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
        ApiConstants.memberRegistration,
        data: formData,
        isMultipart: true, // 👈 IMPORTANT
      );

      return MemberRegisterBasicModel.fromJson(response);
    } on DioException catch (e) {
      if (e.error is NoInternetException) {
        showNoInternetScreen(
          context,
          onRetry:
              () => memberRegistration(
                context: context,
                fullName: fullName,
                email: email,
                profileImage: profileImage,
                gender: gender,
                language: language,
                state: state,

                contactNumber: contactNumber,
                dateIncorporation: dateIncorporation,

                natureOrganization: natureOrganization,

                parentOrganizationName: parentOrganizationName,
                postalAddress: postalAddress,
                selectAssociation: selectAssociation,
                organizationType: organizationType,
                organizationName: organizationName,
                countryCode: countryCode,
                designation: designation,
                gstNumber: gstNumber,
                organizationEmailId: organizationEmailId,
                panNumber: phoneNumber,
                phoneNumber: phoneNumber,
              ),
        );
        throw NoInternetException();
      } else if (e.error is ServerException) {
        showServerErrorScreen(
          context,
          onRetry:
              () => memberRegistration(
                context: context,
                fullName: fullName,
                email: email,
                profileImage: profileImage,
                gender: gender,
                language: language,
                state: state,

                contactNumber: contactNumber,
                dateIncorporation: dateIncorporation,

                natureOrganization: natureOrganization,

                parentOrganizationName: parentOrganizationName,
                postalAddress: postalAddress,
                selectAssociation: selectAssociation,
                organizationType: organizationType,
                organizationName: organizationName,
                countryCode: countryCode,
                designation: designation,
                gstNumber: gstNumber,
                organizationEmailId: organizationEmailId,
                panNumber: phoneNumber,
                phoneNumber: phoneNumber,
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

  Future<AssociationRegistrationModel> associationRegistration({
    required BuildContext context,
    required String associationName,
    required String govtLegalRegistrationNumber,
    required String yearFormation,
    required String fullAddress,
    required String city,
    required String selectState,
    required String pin,
    required String presidentSecretary,
    required String mobile,
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
        "phoneNumber": mobile,

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
      final response = await _api.postMultipart(
        ApiConstants.associationRegistration,
        data: formData,
        isMultipart: true, // 👈 IMPORTANT
        requiresAuth: false


      );

      return AssociationRegistrationModel.fromJson(response);
    } on DioException catch (e) {
      if (e.error is NoInternetException) {
        showNoInternetScreen(
          context,
          onRetry:
              () => associationRegistration(
                context: context,
                associationName: associationName,
                govtLegalRegistrationNumber: govtLegalRegistrationNumber,
                yearFormation: yearFormation,
                fullAddress: fullAddress,
                city: city,
                selectState: selectState,
                pin: pin,
                presidentSecretary: presidentSecretary,
                mobile: mobile,
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
              () => associationRegistration(
                  context: context,
                  associationName: associationName,
                  govtLegalRegistrationNumber: govtLegalRegistrationNumber,
                  yearFormation: yearFormation,
                  fullAddress: fullAddress,
                  city: city,
                  selectState: selectState,
                  pin: pin,
                  presidentSecretary: presidentSecretary,
                  mobile: mobile,
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


  Future<GetAllAssociationModel> getAllAssociationApi({

    required BuildContext context,
  }) async {
    try {
      final response = await _api.get(
        ApiConstants.allAssociation,

        requiresAuth: false,
      );

      return GetAllAssociationModel.fromJson(response);
      //  return LoginModel.fromJson(response['user']);
    } on DioException catch (e) {
      if (e.error is NoInternetException) {
        showNoInternetScreen(
          context,
          onRetry: () => getAllAssociationApi( context: context),
        );
        throw NoInternetException();
      } else if (e.error is ServerException) {
        showServerErrorScreen(
          context,
          onRetry: () => getAllAssociationApi( context: context),
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
