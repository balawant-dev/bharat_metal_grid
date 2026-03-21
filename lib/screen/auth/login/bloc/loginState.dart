import 'package:equatable/equatable.dart';

class SignInState extends Equatable {
  final bool hasError;
  final bool isLoading;
  final bool isSuccess;
  final String? successMessage;
  final String? errorMessage;
  final String? warningMessage;

  SignInState({
    this.successMessage,
    this.errorMessage,
    this.warningMessage,
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

}){
    return SignInState(
      hasError: hasError?? this.hasError,
      isLoading: isLoading?? this.isLoading,
      isSuccess: isSuccess ??this.isSuccess,
      successMessage: successMessage,
      errorMessage: errorMessage,
      warningMessage: warningMessage,

    );

  }

  @override
  List<Object?> get props =>
      [isLoading, hasError, isSuccess, successMessage, errorMessage, warningMessage];
}