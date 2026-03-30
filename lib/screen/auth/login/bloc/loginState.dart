// import 'dart:ui';
//
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
//
// class SignInState extends Equatable {
//   final bool hasError;
//   final bool isLoading;
//   final bool isSuccess;
//   final String? successMessage;
//   final String? errorMessage;
//   final String? warningMessage;
//   String? displayMessage;
//   Color messageColor = Colors.red;
//
//   SignInState({
//     this.successMessage,
//     this.errorMessage,
//     this.warningMessage,
//     this.isLoading = false,
//     this.hasError = false,
//     this.isSuccess = false,
//
//   });
//
//   SignInState copyWith({
//      bool? isLoading,
//      bool? isSuccess,
//      bool? hasError,
//     String? successMessage,
//     String? errorMessage,
//     String? warningMessage,
//
// }){
//     return SignInState(
//       hasError: hasError?? this.hasError,
//       isLoading: isLoading?? this.isLoading,
//       isSuccess: isSuccess ??this.isSuccess,
//       successMessage: successMessage,
//       errorMessage: errorMessage,
//       warningMessage: warningMessage,
//
//     );
//
//   }
//
//   @override
//   List<Object?> get props =>
//       [isLoading, hasError, isSuccess, successMessage, errorMessage, warningMessage];
// }




import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SignInState extends Equatable {
  final bool hasError;
  final bool isLoading;
  final bool isSuccess;

  final String? successMessage;
  final String? errorMessage;
  final String? warningMessage;

  final String? displayMessage;
  final Color? messageColor;

  const SignInState({
    this.successMessage,
    this.errorMessage,
    this.warningMessage,
    this.displayMessage,
    this.messageColor,
    this.isLoading = false,
    this.hasError = false,
    this.isSuccess = false,

  });

  SignInState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? hasError,
    String? successMessage,
    String? errorMessage,
    String? warningMessage,
    String? displayMessage,
    Color? messageColor,
    bool clearMessage = false, // 👈 add this
  }) {
    return SignInState(
      hasError: hasError ?? this.hasError,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      successMessage: successMessage,
      errorMessage: errorMessage,
      warningMessage: warningMessage,
      displayMessage: clearMessage ? null : (displayMessage ?? this.displayMessage),
      messageColor: messageColor ?? this.messageColor,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    hasError,
    isSuccess,
    successMessage,
    errorMessage,
    warningMessage,
    displayMessage,
    messageColor,
  ];
}