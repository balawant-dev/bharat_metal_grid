import 'dart:io';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/exceptions/app_exceptions.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/network/network_utils.dart';
import '../../../../core/services/secure_storage_service.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../model/createOrderModel.dart';
import '../model/createPostModel.dart';
import '../model/getPostModel.dart';
import '../model/membershipAssignmentModel.dart';
import '../model/postDetailModel.dart';
class PostRepo {
  final ApiService _api = ApiService();

  Future<CreatePostModel> createPost({
    required BuildContext context,
    required String title,
    required String description,


    required File? profileImage,
  }) async {
    try {
      final formData = FormData.fromMap({
        "title": title,
        "description": description,


        if (profileImage != null)
          "image": await MultipartFile.fromFile(
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
        ApiConstants.post,
        data: formData,
        isMultipart: true, // 👈 IMPORTANT
      );

      return CreatePostModel.fromJson(response);
    } on DioException catch (e) {
      if (e.error is NoInternetException) {
        showNoInternetScreen(
          context,
          onRetry:
              () => createPost(
                context: context,
                title: title,
                description: description,
                profileImage: profileImage,

              ),
        );
        throw NoInternetException();
      } else if (e.error is ServerException) {
        showServerErrorScreen(
          context,
          onRetry:
              () => createPost(
                context: context,
                title: title,
                description: description,
                profileImage: profileImage,

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




  Future<GetPostModel> getPostApi({

    required BuildContext context,
  }) async {
    try {
      final response = await _api.get(
        ApiConstants.post,

        requiresAuth: true,
      );

      return GetPostModel.fromJson(response);
      //  return LoginModel.fromJson(response['user']);
    } on DioException catch (e) {
      if (e.error is NoInternetException) {
        showNoInternetScreen(
          context,
          onRetry: () => getPostApi( context: context),
        );
        throw NoInternetException();
      } else if (e.error is ServerException) {
        showServerErrorScreen(
          context,
          onRetry: () => getPostApi( context: context),
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
    Future<MembershipAssignmentModel> getMembershipAssignmentApi({

    required BuildContext context,
  }) async {
    try {
      final response = await _api.get(
        ApiConstants.membershipAssignment,

        requiresAuth: true,
      );

      return MembershipAssignmentModel.fromJson(response);
      //  return LoginModel.fromJson(response['user']);
    } on DioException catch (e) {
      if (e.error is NoInternetException) {
        showNoInternetScreen(
          context,
          onRetry: () => getPostApi( context: context),
        );
        throw NoInternetException();
      } else if (e.error is ServerException) {
        showServerErrorScreen(
          context,
          onRetry: () => getPostApi( context: context),
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


  Future<PostDetailModel> getPostDetailApi({

    required BuildContext context,
    required String id,
  }) async {
    try {
      final response = await _api.get(
        "${ApiConstants.post}/$id",

        requiresAuth: true,
      );

      return PostDetailModel.fromJson(response);
      //  return LoginModel.fromJson(response['user']);
    } on DioException catch (e) {
      if (e.error is NoInternetException) {
        showNoInternetScreen(
          context,
          onRetry: () => getPostApi( context: context),
        );
        throw NoInternetException();
      } else if (e.error is ServerException) {
        showServerErrorScreen(
          context,
          onRetry: () => getPostApi( context: context),
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

  Future<PostDetailModel> postReactionApi({

    required BuildContext context,
    required String id,
    required String type,
  }) async {
    try {
      final response = await _api.post(
        ApiConstants.postReaction,
        data: {
          "type":type,
          "postId":id,
        },

        requiresAuth: true,
      );

      return PostDetailModel.fromJson(response);
      //  return LoginModel.fromJson(response['user']);
    } on DioException catch (e) {
      if (e.error is NoInternetException) {
        showNoInternetScreen(
          context,
          onRetry: () => getPostApi( context: context),
        );
        throw NoInternetException();
      } else if (e.error is ServerException) {
        showServerErrorScreen(
          context,
          onRetry: () => getPostApi( context: context),
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
  }  Future<CreateOrderModel> createOrderApi({

    required BuildContext context,
    required String membershipPlanID,

  }) async {
    try {
      final response = await _api.post(
        ApiConstants.createOrder,
        data: {
          "membershipPlan":membershipPlanID,

        },

        requiresAuth: true,
      );

      return CreateOrderModel.fromJson(response);
      //  return LoginModel.fromJson(response['user']);
    } on DioException catch (e) {
      if (e.error is NoInternetException) {
        showNoInternetScreen(
          context,
          onRetry: () => getPostApi( context: context),
        );
        throw NoInternetException();
      } else if (e.error is ServerException) {
        showServerErrorScreen(
          context,
          onRetry: () => getPostApi( context: context),
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
