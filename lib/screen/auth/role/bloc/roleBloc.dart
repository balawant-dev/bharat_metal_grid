import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/router/navigation/nav.dart';
import '../../../../app/router/navigation/routes.dart';
import '../../../../core/services/secure_storage_service.dart';

import '../../../settings/appSettings/appSettings.dart';
import '../../repo/authRepo.dart';
import 'roleEvent.dart';
import 'roleState.dart';

class SelectRoleBloc extends Bloc<SelectRoleEvent, SelectRoleState> {
  AuthRepo authRepo = AuthRepo();

  SelectRoleBloc() : super(SelectRoleState()) {
    on<ResetVerifyRoleEvent>((event, emit) {
      emit(SelectRoleState()); // pura state reset
    });
    on<VerifyRoleEvent>(_onSendOTPSubmitted);
  }

  Future<void> _onSendOTPSubmitted(
      VerifyRoleEvent event,
    Emitter<SelectRoleState> emit,
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
      final response = await authRepo.verifyRole(
        phone: event.mobileNumber,
        userType     : event.userType,
        context: event.context,

      );
      if ( response.success == true) {
        if(event.userType=="Member"){
          Nav.push(event.context, Routes.memberRegister, extra: event.mobileNumber);

        }else if(event.userType=="Association"){
          Nav.push(event.context, Routes.associationRegister, extra: event.mobileNumber);

        }


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
