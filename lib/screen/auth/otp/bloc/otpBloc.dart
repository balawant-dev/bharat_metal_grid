import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/router/navigation/nav.dart';
import '../../../../app/router/navigation/routes.dart';
import '../../../../core/services/secure_storage_service.dart';

import '../../../homeScreen/bloc/homeBloc.dart';
import '../../../homeScreen/bloc/homeEvent.dart';
import '../../../profile/bloc/profileBloc.dart';
import '../../../profile/bloc/profileEvent.dart';
import '../../../settings/appSettings/appSettings.dart';
import '../../repo/authRepo.dart';
import 'otpEvent.dart';
import 'otpState.dart';

class OTPBloc extends Bloc<OTPEvent, OTPState> {
  AuthRepo authRepo = AuthRepo();

  OTPBloc() : super(OTPState()) {
    on<ResetVerifyOtpEvent>((event, emit) {
      emit(OTPState()); // pura state reset
    });
    on<VerifyOtpEvent>(_onSendOTPSubmitted);
  }

  Future<void> _onSendOTPSubmitted(
    VerifyOtpEvent event,
    Emitter<OTPState> emit,
  ) async {
    // if (event.otp!.length != 4) {
    //   emit(
    //     state.copyWith(
    //       isLoading: false,
    //       errorMessage: "Enter a valid 4 digit OTP",
    //     ),
    //   );
    //   return;
    // }

    emit(state.copyWith(isLoading: true));

    try {
      final response = await authRepo.verifyOtp(
        phone: event.mobileNumber,
        otp: event.otp,
        context: event.context,

      );
      print("✅ Store1");
      if ( response.success == true) {
        print("✅ Store2");

        final userType = response.data!.userType??"Not Avaible";
        print("✅ Store3");


        if(response.token==null||response.token=="null"||response.token==""){
          print("✅ Store4");
          Nav.go(event.context, Routes.rideSelect, extra: event.mobileNumber);
        }else{
          print("✅ Store5");
          if (userType == "Association") {
            print("✅ Store6");
            debugPrint("UserType >>>>>>>> $userType");
            event.context.read<ProfileBloc>().add(
              FetchProfileAssociationEvent(context: event.context),
            );
          } else if (userType == "Member") {
            print("✅ Store7");
            event.context.read<ProfileBloc>().add(
              FetchProfileMemberEvent(context: event.context),
            );
            print("✅ Store8");
          }
          event.context.read<HomeBloc>().add(FetchIndustryNewsEvent(context: event.context,limit: 10,page: 1));
          event.context.read<HomeBloc>().add(FetchLatestNoticesEvent(context: event.context,page: 1,limit: 10));
          event.context.read<HomeBloc>().add(GallerListEvent(context: event.context,page: 1,limit: 10));
          Nav.go(event.context, Routes.home);
          print("✅ Store9");
        }

        await SecureStorageService.saveToken(response.token!);
        final isToken = await SecureStorageService.getToken();
        await SecureStorageService.saveUserType(response.data!.userType!);
        await AppSettings.setUserType( userType: userType??"",); // ya jo bhi value ho



        final userType2 = await SecureStorageService.getUserType();


        print("✅ Store>>>>>>>Store>>>>>>>>>>>token $isToken");
        print("✅ UserID>>>>>>>User Type>>>>>>>>>>>token $userType2");

        // await SecureStorageService.saveToken(response.token!);
        // await SecureStorageService.saveUserID(response.data!.user!.sId!);
        // await SecureStorageService.saveIsAgent(response.data!.isAgent??false);
        // await SecureStorageService.saveIsUser(response.data!.isUser??false);
        // final isToken = await SecureStorageService.getToken();
        // final isAgent = await SecureStorageService.getIsAgent();
        // final isUser = await SecureStorageService.getIsUser();
        // final userID = await SecureStorageService.getUserID();
        // print("✅ isAgent >>>>Store>>>>$isAgent");
        // print("✅ isUser >>>>>>>>$isUser");
        // print("✅ Store>>>>>>>Store>>>>>>>>>>>token $isToken");
        // print("✅ UserID>>>>>>>UserID>>>>>>>>>>>token $userID");
        // await AppSettings.setUserType(isAgent: isAgent, isUser: isUser,userID: userID??""); // ya jo bhi value ho
        emit(
          state.copyWith(
            errorMessage: "Verify OTP Successfully",
            isLoading: false,
            isSuccess: true,

          ),
        );


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
}
