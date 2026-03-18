import 'dart:io';


import 'package:bharat_metal_grid/screen/homeScreen/model/industryNewsModel.dart';
import 'package:bharat_metal_grid/screen/homeScreen/model/latestNoticesModel.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/exceptions/app_exceptions.dart';
import '../../../core/network/api_service.dart';
import '../../../core/network/network_utils.dart';
import '../../../core/services/secure_storage_service.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../model/bannerModel.dart';
import '../model/galleryListModel.dart';
import '../model/industryNewsDetailModel.dart';
import '../model/latestNoticeDetailModel.dart';




class HomeRepo {
  final ApiService _api = ApiService();

  Future<IndustryNewsModel> getIndustryNews({required BuildContext context, required int page, required int limit}) async {
    try {
      final response = await _api.get("${ApiConstants.industryNews}?page=$page&limit=$limit",requiresAuth: true);
      return IndustryNewsModel.fromJson(response);
    } on DioException catch (e) {
      if (e.error is NoInternetException) {
        showNoInternetScreen(context, onRetry: () => getIndustryNews(context:context,limit: limit,page:page ));
        throw NoInternetException();
      } else if (e.error is ServerException) {
        showServerErrorScreen(context, onRetry: () => getIndustryNews(context:context,page: page,limit: limit));
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
  }   Future<GalleryListModel> getGalleryListApi({required BuildContext context, required int page, required int limit}) async {
    try {
      final response = await _api.get("${ApiConstants.gallery}?page=$page&limit=$limit",requiresAuth: true);
      return GalleryListModel.fromJson(response);
    } on DioException catch (e) {
      if (e.error is NoInternetException) {
        showNoInternetScreen(context, onRetry: () => getGalleryListApi(context:context,limit: limit,page:page ));
        throw NoInternetException();
      } else if (e.error is ServerException) {
        showServerErrorScreen(context, onRetry: () => getGalleryListApi(context:context,page: page,limit: limit));
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


  Future<IndustryNewsDetailModel> getIndustryNewsDetail({required BuildContext context, required String id}) async {
    try {
      final response = await _api.get("${ApiConstants.industryNews}/$id",requiresAuth: true);
      return IndustryNewsDetailModel.fromJson(response);
    } on DioException catch (e) {
      if (e.error is NoInternetException) {
        showNoInternetScreen(context, onRetry: () => getIndustryNewsDetail(context:context,id: id));
        throw NoInternetException();
      } else if (e.error is ServerException) {
        showServerErrorScreen(context, onRetry: () => getIndustryNewsDetail(context:context,id: id,));
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

  Future<GetBannerModel> getBannerApi({required BuildContext context}) async {
    try {
      final response = await _api.get(ApiConstants.banners,requiresAuth: true);
      return GetBannerModel.fromJson(response);
    } on DioException catch (e) {
      if (e.error is NoInternetException) {
        showNoInternetScreen(context, onRetry: () => getBannerApi(context:context));
        throw NoInternetException();
      } else if (e.error is ServerException) {
        showServerErrorScreen(context, onRetry: () => getBannerApi(context:context));
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


  Future<LatestNoticesModel> getLatestNotices({required BuildContext context, required int page, required int limit}) async {
    try {
      final response = await _api.get("${ApiConstants.latestNotices}?page=$page&limit=$limit",requiresAuth: true);
      return LatestNoticesModel.fromJson(response);
    } on DioException catch (e) {
      if (e.error is NoInternetException) {
        showNoInternetScreen(context, onRetry: () => getLatestNotices(context:context,limit: limit,page: page));
        throw NoInternetException();
      } else if (e.error is ServerException) {
        showServerErrorScreen(context, onRetry: () => getLatestNotices(context:context,page: page,limit:limit ));
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
  }  Future<LatestNoticesDetailModel> getLatestNoticesDetail({required BuildContext context, required String id}) async {
    try {
      final response = await _api.get("${ApiConstants.latestNotices}/$id",requiresAuth: true);
      return LatestNoticesDetailModel.fromJson(response);
    } on DioException catch (e) {
      if (e.error is NoInternetException) {
        showNoInternetScreen(context, onRetry: () => getLatestNoticesDetail(context:context,id: id));
        throw NoInternetException();
      } else if (e.error is ServerException) {
        showServerErrorScreen(context, onRetry: () => getLatestNoticesDetail(context:context,id: id,));
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
