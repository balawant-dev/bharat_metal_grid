import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/router/navigation/nav.dart';
import '../../../../app/router/navigation/routes.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../../settings/appSettings/appSettings.dart';
import '../../repo/authRepo.dart';
import '../repo/registerRepo.dart';
import 'registerEvent.dart';
import 'registerState.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterRepo repo = RegisterRepo();

  RegisterBloc() : super(RegisterState()) {
    on<ResetRegisterEvent>((event, emit) {
      emit(RegisterState()); // pura state reset
    });
    on<MemberRegistrationSummitedEvent>(_onMemberRegisterSubmitted);
    on<AssociationRegistrationSummitedEvent>(_onAssociationRegisterSubmitted);
    on<AllAssociationEvent>(_getAllAssociation);
  }

  Future<void> _onMemberRegisterSubmitted(
      MemberRegistrationSummitedEvent event,
    Emitter<RegisterState> emit,
  ) async {


    emit(state.copyWith(isLoading: true));

    try {
      final response = await repo.memberRegistration(


        designation: event.designation,
        gstNumber:event.gstNumber ,
        organizationEmailId:event.organizationEmailId ,
        organizationName:event.organizationName ,
        organizationType: event.organizationType,
        panNumber:event.panNumber ,
        phoneNumber: event.phoneNumber,
        profileImage: event.profileImage,





        countryCode: "+91",
        email: event.email,

        context: event.context,

        fullName: event.fullName,
selectAssociation: event.selectAssociation,
        gender: event.gender,
        language: event.language,
        state: event.state,
        parentOrganizationName: event.parentOrganizationName,
        postalAddress: event.postalAddress,
        dateIncorporation: event.dateIncorporation,

        contactNumber: event.contactNumber,

        natureOrganization: event.natureOrganization,


      );
      if (response != null && response.success == true) {
        emit(
          state.copyWith(
            errorMessage:response.message??  "Member Registered successfully",
            isLoading: false,
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
            isLoading: false,
            errorMessage: "Invalid credentials",
            hasError: true,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }



  Future<void> _onAssociationRegisterSubmitted(
      AssociationRegistrationSummitedEvent event,
    Emitter<RegisterState> emit,
  ) async {


    emit(state.copyWith(isLoading: true));

    try {
      final response = await repo.associationRegistration(
        registrationCertificateImage: event.registrationCertificateImage,
        email: event.email,
        context: event.context,
        profileImage: event.profileImage,
        associationName: event.associationName,
        city: event.city,
        fullAddress: event.fullAddress,
        govtLegalRegistrationNumber: event.govtLegalRegistrationNumber,
        mobile: event.mobile,
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
        emit(
          state.copyWith(
            errorMessage:response.message??  "Member Registered successfully",
            isLoading: false,
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
            isLoading: false,
            errorMessage: "Invalid credentials",
            hasError: true,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void>_getAllAssociation(
      AllAssociationEvent event,
      Emitter<RegisterState> emit,
      ) async {
    emit(state.copyWith(isLoadingAssociation: true));

try {
  final response = await repo.getAllAssociationApi(context: event.context);
  if (response != null && response.success == true) {
    emit(state.copyWith(isLoadingAssociation: false,getAllAssociationModel: response,errorMessage: null));
  }
}
catch(e){
  emit(state.copyWith(isLoadingAssociation: false, errorMessage: e.toString()));
}
  }



}
