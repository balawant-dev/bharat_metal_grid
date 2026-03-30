// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../repo/authRepo.dart';
// import 'loginEvent.dart';
// import 'loginState.dart';
//
// class SignInBloc extends Bloc<SignInEvent, SignInState> {
//   AuthRepo authRepo = AuthRepo();
//
//   SignInBloc() : super(SignInState()) {
//     on<ResetSendOtpEvent>((event, emit) {
//       emit(SignInState()); // pura state reset
//     });
//     on<SendOtpEvent>(_onSendOTPSubmitted);
//   }
//
//   Future<void> _onSendOTPSubmitted(
//     SendOtpEvent event,
//     Emitter<SignInState> emit,
//   ) async {
//     if (event.mobileNumber.isEmpty || event.mobileNumber.length != 10) {
//       emit(state.copyWith(
//         isLoading: false,
//         warningMessage: "Enter valid 10 digit number",
//       ));
//       return;
//     }
//
//     emit(state.copyWith(isLoading: true));
//
//     try {
//       final response = await authRepo.sendOtp(
//         phone: event.mobileNumber,
//         context: event.context,
//       );
//
//       if (response != null && response.success == true) {
//         emit(state.copyWith(
//           isLoading: false,
//           isSuccess: true,
//           successMessage: "OTP sent successfully",
//         ));
//       } else {
//         emit(state.copyWith(
//           isLoading: false,
//           hasError: true,
//           errorMessage: "Invalid credentials",
//         ));
//       }
//     } catch (e) {
//       emit(state.copyWith(
//         isLoading: false,
//         hasError: true,
//         errorMessage: e.toString(),
//       ));
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repo/authRepo.dart';
import 'loginEvent.dart';
import 'loginState.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  AuthRepo authRepo = AuthRepo();

  SignInBloc() : super(const SignInState()) {
    on<ResetSendOtpEvent>((event, emit) {
      emit(const SignInState()); // full reset
    });

    on<SendOtpEvent>(_onSendOTPSubmitted);
    on<ClearMessageEvent>((event, emit) {
      emit(state.copyWith(clearMessage: true));
    });
    on<ShowMessageEvent>((event, emit) {
      emit(state.copyWith(
        displayMessage: event.message,
        messageColor: event.color,
      ));
    });
  }

  Future<void> _onSendOTPSubmitted(
      SendOtpEvent event,
      Emitter<SignInState> emit,
      ) async {

    // 🔴 Validation
    if (event.mobileNumber.isEmpty || event.mobileNumber.length != 10) {
      emit(state.copyWith(
        isLoading: false,
        displayMessage: "Enter valid 10 digit number",
        messageColor: Colors.orange,
      ));
      return;
    }

    emit(state.copyWith(
      isLoading: true,
      displayMessage: null, // clear old message
    ));

    try {
      final response = await authRepo.sendOtp(
        phone: event.mobileNumber,
        context: event.context,
      );

      if (response != null && response.success == true) {
        // 🟢 Success
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          displayMessage: "OTP sent successfully",
          messageColor: Colors.green,
        ));
      } else {
        // 🔴 API fail
        emit(state.copyWith(
          isLoading: false,
          hasError: true,
          displayMessage: "Invalid credentials",
          messageColor: Colors.red,
        ));
      }
    } catch (e) {
      // 🔴 Exception
      emit(state.copyWith(
        isLoading: false,
        hasError: true,
        displayMessage: e.toString(),
        messageColor: Colors.red,
      ));
    }
  }
}