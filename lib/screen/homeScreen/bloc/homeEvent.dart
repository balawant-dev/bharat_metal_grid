import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class HomeEvent extends Equatable{
  HomeEvent();
  @override
  List<Object?> get props => [];
}

class FetchIndustryNewsEvent extends HomeEvent{
  final BuildContext context;
  final int page;
  final int limit;
  FetchIndustryNewsEvent({required this.context,required this.page,required this.limit});

  @override
  List<Object?> get props => [context,page,limit];
}class FetchIndustryNewsDetailEvent extends HomeEvent{
  final BuildContext context;
  final String id;

  FetchIndustryNewsDetailEvent({required this.context,required this.id});

  @override
  List<Object?> get props => [context,id];
}

class FetchLatestNoticesEvent extends HomeEvent{
  final BuildContext context;
  final int page;
  final int limit;
  FetchLatestNoticesEvent({required this.context,required this.page,required this.limit});

  @override
  List<Object?> get props => [context,page,limit];

}
class GallerListEvent extends HomeEvent{
  final BuildContext context;
  final int page;
  final int limit;
  GallerListEvent({required this.context,required this.page,required this.limit});

  @override
  List<Object?> get props => [context,page,limit];

}class FetchBannerEvent extends HomeEvent{
  final BuildContext context;

  FetchBannerEvent({required this.context});

  @override
  List<Object?> get props => [context,];

}

class FetchLatestNoticesDetailEvent extends HomeEvent{
  final BuildContext context;
  final String id;

  FetchLatestNoticesDetailEvent({required this.context,required this.id});

  @override
  List<Object?> get props => [context,id];

}
class ResetHomeEvent extends HomeEvent {
   ResetHomeEvent();
}