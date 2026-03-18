import 'package:equatable/equatable.dart';

import '../model/getProfileAssociationModel.dart';
import '../model/getProfileMemberModel.dart';


class ProfileState extends Equatable {
  final bool isLoading;
  final bool isUpdateLoading;
  final bool hasError;
  final bool isSuccess;
  final bool refreshUI;
  final String? errorMessage;
  final GetProfileAssociationModel? getProfileAssociationModel;
  final GetProfileMemberModel? getProfileMemberModel;
  final String userName;
  final String userEmail;
  final String userPhone;
  final String userProfileImage;
  final String profileCompletionPercentage;
  // final UpdateProfileModel? updateProfileModel;





   ProfileState({
    this.errorMessage,
    this.getProfileAssociationModel,
this.getProfileMemberModel,
    this.isLoading = false,
    this.refreshUI = false,
    this.isUpdateLoading = false,
    this.isSuccess = false,
    this.hasError = false,
    this.userName = "",
    this.userEmail = "",
    this.userPhone = "",
    this.userProfileImage = "",
    this.profileCompletionPercentage = "",




  });

  ProfileState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? hasError,
    bool? refreshUI,
    bool? isUpdateLoading,
    String? errorMessage,
    String? profileCompletionPercentage,
    GetProfileAssociationModel? getProfileAssociationModel,
    GetProfileMemberModel? getProfileMemberModel,
    String? userName,
    String? userEmail,
    String? userPhone,
    String? userProfileImage,



  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      hasError: hasError ?? this.hasError,
      refreshUI: refreshUI ?? this.refreshUI,
      isUpdateLoading: isUpdateLoading ?? this.isUpdateLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      getProfileAssociationModel: getProfileAssociationModel ?? this.getProfileAssociationModel,
      getProfileMemberModel: getProfileMemberModel ?? this.getProfileMemberModel,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      userPhone: userPhone ?? this.userPhone,
      profileCompletionPercentage: profileCompletionPercentage ?? this.profileCompletionPercentage,
        userProfileImage: userProfileImage ?? this.userProfileImage,






    );
  }

  @override
  List<Object?> get props => [isLoading, isUpdateLoading,errorMessage, getProfileAssociationModel,profileCompletionPercentage,refreshUI,hasError,isSuccess,userName,userEmail,userPhone,userProfileImage];
}
