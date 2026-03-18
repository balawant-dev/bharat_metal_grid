import 'package:equatable/equatable.dart';

import '../model/cmsModel.dart';



class CMSState extends Equatable {
  final CMSModel? cmsModel;

  
  final bool isLoading;
  final bool isUpdateLoading;
  final String? errorMessage;

  const CMSState({
    this.cmsModel,



    this.isLoading = false,
    this.isUpdateLoading = false,
    this.errorMessage,
  });

  CMSState copyWith({
    CMSModel? cmsModel,

    bool? isLoading,
    bool? isUpdateLoading,
    String? errorMessage,
  }) {
    return CMSState(
      cmsModel: cmsModel ?? this.cmsModel,

      isLoading: isLoading ?? this.isLoading,
      isUpdateLoading: isUpdateLoading ?? this.isUpdateLoading,
      errorMessage: errorMessage ?? this.errorMessage,

    );
  }

  @override
  List<Object?> get props => [
    cmsModel,

    isLoading,
    isUpdateLoading,
    errorMessage,

  ];
}
