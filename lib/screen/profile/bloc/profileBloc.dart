import 'package:bharat_metal_grid/screen/profile/bloc/profileEvent.dart';
import 'package:bharat_metal_grid/screen/profile/bloc/profileState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/secure_storage_service.dart';
import '../../settings/appSettings/appSettings.dart';
import '../repo/profileRepo.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileRepo api = ProfileRepo();

  ProfileBloc() : super(ProfileState()) {
    on<ResetProfileEvent>((event, emit) {
      emit(ProfileState());
    });
    on<FetchProfileAssociationEvent>(_onFetchProfileAssociation);
    on<FetchProfileMemberEvent>(_onFetchProfileMember);
    on<AssociationUpdateSummitedEvent>(_onAssociationUpdateSubmitted);
  }

  Future<void> _onFetchProfileAssociation(
    FetchProfileAssociationEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final response = await api.getProfileAssociation(event.context);
    if (response.success == true) {

      await SecureStorageService.saveUseEmail(response.data!.email!);
      await SecureStorageService.saveUserName(response.data!.associationName!);
      await SecureStorageService.saveUserPhone(response.data!.phoneNumber!);
      await SecureStorageService.saveUserProfileImage(response.data!.profileImage??"");
      await SecureStorageService.saveProfileCompletionPercentage(response.data!.profileCompletionPercentage.toString()??"");

      final isEmail = await SecureStorageService.getUserEmail();
      final isName = await SecureStorageService.getUserName();
      final isPhone = await SecureStorageService.getUserPhone();
      final userType = await SecureStorageService.getUserType();
      final profileImage = await SecureStorageService.getUserProfileImage();
      final profileCompletionPercentage = await SecureStorageService.getProfileCompletionPercentage();

      print("✅ Store>>>>>>>Store>>>>>>>>>>>isEmail $isEmail");
      print("✅ isName>>>>>>>isName>>>>>>>>>>>isName $isName");
      print("✅ Store>>>>>>>Store>>>>>>>>>>>isPhone $isPhone");
      print("✅ Store>>>>>>>profileCompletionPercentage>>>>>>>>>>>profileCompletionPercentage $profileCompletionPercentage");
      print("✅ userType>>>>>>>User Type>>>>>>>>>>>userType $userType");
      await AppSettings.setUserDetail(
          userName: isName ?? "Not Store Name",
          userPhone: isPhone ?? "Not Store Phone",
          userEmail: isEmail ?? "Not Store Email",
          userProfileImage: profileImage??"Not Store Profile Image",
          profileCompletionPercentage: profileCompletionPercentage??"Not Store Profile Completion Percentage"

      );
      await   AppSettings.initUserType(); //

      emit(
        state.copyWith(
          userName: AppSettings.userName,
          userEmail: AppSettings.userEmail,
          userPhone: AppSettings.userPhone,
          userProfileImage: AppSettings.userProfileImage,
          profileCompletionPercentage:
          AppSettings.profileCompletionPercentage,
          isLoading: false,
          getProfileAssociationModel: response,
        ),
      );
    }
    try {

    } catch (e) {
      print(">>>>>>>>>>>>>>>>>>get Profile 🤦‍♂️🤦‍♂️🤦‍♂️Exception Association Error>>>>$e");
    }
  }

  Future<void> _onAssociationUpdateSubmitted(
      AssociationUpdateSummitedEvent event,
      Emitter<ProfileState> emit,
      ) async {


    emit(state.copyWith(isUpdateLoading: true));

    try {
      final response = await api.associationUpdateProfile(
          registrationCertificateImage: event.registrationCertificateImage,
          email: event.email,
          context: event.context,
          profileImage: event.profileImage,
          associationName: event.associationName,
          city: event.city,
          fullAddress: event.fullAddress,
          govtLegalRegistrationNumber: event.govtLegalRegistrationNumber,
          // mobile: event.mobile,
          presidentSecretary: event.presidentSecretary,
          registrationCertificateType: event.registrationCertificateType,
          countryCode: "+91",
          selectState: event.selectState,
          verifiedAt: event.verifiedAt,
          verifiedBy: event.verifiedBy,

          pin: event.pin,
          yearFormation: event.yearFormation


      );
      if (response != null && response.success == true) {
        add(FetchProfileAssociationEvent(context: event.context));
        emit(
          state.copyWith(
            errorMessage:response.message??  "Association Update successfully",
            isUpdateLoading: false,
            isSuccess: true,

          ),
        );

        await SecureStorageService.saveToken(response.token!);
        await SecureStorageService.saveUserType(response.userType!);

        final isToken = await SecureStorageService.getToken();

        final userType = await SecureStorageService.getUserType();

        print("✅ Store>>>>>>>Store>>>>>>>>>>>token $isToken");
        print("✅ UserID>>>>>>>User Type>>>>>>>>>>>token $userType");
        await AppSettings.setUserType( userType: userType??""); // ya jo bhi value ho


      } else {
        emit(
          state.copyWith(
            isUpdateLoading: false,
            errorMessage: "Invalid credentials",
            hasError: true,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(isUpdateLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _onFetchProfileMember(
    FetchProfileMemberEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final response = await api.getProfileMember(event.context);
      if (response.success == true) {
        await SecureStorageService.saveUseEmail(response.data!.email!);
        await SecureStorageService.saveUserName(response.data!.fullName!);
        await SecureStorageService.saveUserPhone(response.data!.phoneNumber!);
        await SecureStorageService.saveUserProfileImage(response.data!.profileImage!);

        final isEmail = await SecureStorageService.getUserEmail();
        final isName = await SecureStorageService.getUserName();
        final isPhone = await SecureStorageService.getUserPhone();
        final userType = await SecureStorageService.getUserType();
        final profileImage = await SecureStorageService.getUserProfileImage();

        print("✅ Store>>>>>>>Store>>>>>>>>>>>isEmail $isEmail");
        print("✅ isName>>>>>>>isName>>>>>>>>>>>isName $isName");
        print("✅ Store>>>>>>>Store>>>>>>>>>>>isPhone $isPhone");
        print("✅ userType>>>>>>>User Type>>>>>>>>>>>userType $userType");
        await AppSettings.setUserDetail(
          userName: isName ?? "Not Store Name",
          userPhone: isPhone ?? "Not Store Phone",
          userEmail: isEmail ?? "Not Store Email",
          userProfileImage: profileImage??"Not Store Profile Image",
          profileCompletionPercentage: "Not Store Profile Completion Percentage"
        );
        emit(state.copyWith(isLoading: false, getProfileMemberModel: response));
      }
    } catch (e) {
      print(">>>>>>>>>>>>>>>>>> Member get 🤦‍♂️🤦‍♂️🤦‍♂️ Profile Exception Error>>>>$e");
    }
  }
}
