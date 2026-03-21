import 'package:equatable/equatable.dart';

class OTPState extends Equatable {
  final bool isLoading;

  final String? successMessage;
  final String? errorMessage;
  final String? warningMessage;

  final bool isSuccess;
  final bool isAgent;
  final bool isUser;
  final bool hasError;

  OTPState({
    this.isLoading = false,
    this.hasError = false,
    this.isSuccess = false,
    this.isAgent = false,
    this.isUser = false,
    this.successMessage,
    this.errorMessage,
    this.warningMessage,
  });

  OTPState copyWith({
     bool? isLoading,
    String? successMessage,
    String? errorMessage,
    String? warningMessage,
     bool? isSuccess,
     bool? isAgent,
     bool? isUser,
     bool? hasError,

}){
    return OTPState(
      isLoading: isLoading?? this.isLoading,
        successMessage: successMessage,
        errorMessage: errorMessage,
        warningMessage: warningMessage,
      hasError: hasError?? this.hasError,
      isSuccess: isSuccess ??this.isSuccess,
      isAgent: isAgent??this.isAgent,
      isUser: isUser??this.isUser
    );

  }
  @override
  List<Object?> get props =>
      [isLoading, isSuccess, hasError, successMessage, errorMessage, warningMessage];
}