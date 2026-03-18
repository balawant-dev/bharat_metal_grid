import 'package:equatable/equatable.dart';

import '../model/bannerModel.dart';
import '../model/galleryListModel.dart';
import '../model/industryNewsDetailModel.dart';
import '../model/industryNewsModel.dart';
import '../model/latestNoticeDetailModel.dart';
import '../model/latestNoticesModel.dart';

class HomeState extends Equatable {
  final LatestNoticesModel? latestNoticesModel;
  final IndustryNewsModel? industryNewsModel;
  final IndustryNewsDetailModel? industryNewsDetailModel;
  final LatestNoticesDetailModel? latestNoticesDetailModel;
  final GalleryListModel? galleryListModel;
  final GetBannerModel? getBannerModel;
  final bool isLoading;
  final bool isUpdateLoading;
  final String? errorMessage;

  const HomeState({
    this.latestNoticesModel,
    this.industryNewsModel,
    this.getBannerModel,

    this.industryNewsDetailModel,
    this.galleryListModel,
    this.latestNoticesDetailModel,
    this.isLoading = false,
    this.isUpdateLoading = false,
    this.errorMessage,
  });

  HomeState copyWith({
    LatestNoticesModel? latestNoticesModel,
    GetBannerModel? getBannerModel,
    GalleryListModel? galleryListModel,
    IndustryNewsModel? industryNewsModel,
    IndustryNewsDetailModel? industryNewsDetailModel,
    LatestNoticesDetailModel? latestNoticesDetailModel,
    bool? isLoading,
    bool? isUpdateLoading,
    String? errorMessage,
  }) {
    return HomeState(
      latestNoticesModel: latestNoticesModel ?? this.latestNoticesModel,
      industryNewsModel: industryNewsModel ?? this.industryNewsModel,
      isLoading: isLoading ?? this.isLoading,
      isUpdateLoading: isUpdateLoading ?? this.isUpdateLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      industryNewsDetailModel: industryNewsDetailModel ?? this.industryNewsDetailModel,
      latestNoticesDetailModel: latestNoticesDetailModel ?? this.latestNoticesDetailModel,
      galleryListModel: galleryListModel ?? this.galleryListModel,
      getBannerModel: getBannerModel ?? this.getBannerModel,
    );
  }

  @override
  List<Object?> get props => [
    latestNoticesModel,
    industryNewsModel,
    isLoading,
    isUpdateLoading,
    getBannerModel,
    errorMessage,
    industryNewsDetailModel,
    latestNoticesDetailModel,

    galleryListModel,
  ];
}
