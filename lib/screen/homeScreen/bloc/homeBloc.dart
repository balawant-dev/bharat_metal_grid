import 'package:bharat_metal_grid/screen/homeScreen/bloc/homeEvent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repo/homeRepo.dart';
import 'homeState.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState>{
  HomeRepo api=HomeRepo();
  HomeBloc() : super(HomeState()){
    on<ResetHomeEvent>((event, emit) {
      emit(HomeState());
    });


    on<FetchIndustryNewsEvent>(_onFetchFetchIndustryNews);
    on<FetchLatestNoticesEvent>(_onFetchFetchLatestNotices);
    on<FetchIndustryNewsDetailEvent>(_onFetchFetchIndustryDetailNews);
on<FetchLatestNoticesDetailEvent>(_onFetchFetchLatestNoticesDetail);
on<GallerListEvent>(_onFetchGallerList);
on<FetchBannerEvent>(_onFetchBanner);

  }

  Future<void> _onFetchFetchIndustryNews(
      FetchIndustryNewsEvent event,
      Emitter<HomeState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final response = await api.getIndustryNews(context:event.context,limit: event.limit,page: event.page);
      if (response.success == true) {

        emit(
          state.copyWith(
            isLoading: false,
            industryNewsModel: response,
          ),
        );
      }
    } catch (e) {
      print(">>>>>>>>>>>>>>>>>>get getIndustryNews Exception Error>>>>$e");
    }
  }   Future<void> _onFetchBanner(
      FetchBannerEvent event,
      Emitter<HomeState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final response = await api.getBannerApi(context:event.context);
      if (response.success == true) {

        emit(
          state.copyWith(
            isLoading: false,
            getBannerModel: response,
          ),
        );
      }
    } catch (e) {
      print(">>>>>>>>>>>>>>>>>>get getBannerModel Exception Error>>>>$e");
    }
  }
  Future<void> _onFetchGallerList(




      GallerListEvent event,
      Emitter<HomeState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final response = await api.getGalleryListApi(context:event.context,limit: event.limit,page: event.page);
      if (response.success == true) {

        emit(
          state.copyWith(
            isLoading: false,
            galleryListModel: response,
          ),
        );
      }
    } catch (e) {
      print(">>>>>>>>>>>>>>>>>>get galleryListModel Exception Error>>>>$e");
    }
  }

  Future<void> _onFetchFetchIndustryDetailNews(
      FetchIndustryNewsDetailEvent event,
      Emitter<HomeState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null,industryNewsDetailModel:null));
    try {
      final response = await api.getIndustryNewsDetail(context:event.context,id: event.id);
      if (response.success == true) {

        emit(
          state.copyWith(
            isLoading: false,
            industryNewsDetailModel: response,
          ),
        );
      }
    } catch (e) {
      print(">>>>>>>>>>>>>>>>>>get getIndustryNews Exception Error>>>>$e");
    }
  }

  Future<void> _onFetchFetchLatestNotices(
      FetchLatestNoticesEvent event,
      Emitter<HomeState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final response = await api.getLatestNotices(context:event.context,limit: event.limit,page: event.page);
      if (response.success == true) {



        emit(state.copyWith(isLoading: false, latestNoticesModel: response));
      }
    } catch (e) {
      print(">>>>>>>>>>>>>>>>>>get getLatestNotices Exception Error>>>>$e");
    }
  } Future<void> _onFetchFetchLatestNoticesDetail(
      FetchLatestNoticesDetailEvent event,
      Emitter<HomeState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null,latestNoticesDetailModel:null));
    try {
      final response = await api.getLatestNoticesDetail(context:event.context,id: event.id);
      if (response.success == true) {



        emit(state.copyWith(isLoading: false, latestNoticesDetailModel: response));
      }
    } catch (e) {
      print(">>>>>>>>>>>>>>>>>>get latestNoticesDetailModel Exception Error>>>>$e");
    }
  }
}