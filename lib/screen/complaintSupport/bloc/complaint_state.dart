import 'package:equatable/equatable.dart';

class ComplaintState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  final String? emailError;
  final String? mobileError;
  final String? remarkError;

  const ComplaintState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.emailError,
    this.mobileError,
    this.remarkError,
  });

  ComplaintState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    String? emailError,
    String? mobileError,
    String? remarkError,
  }) {
    return ComplaintState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
      emailError: emailError,
      mobileError: mobileError,
      remarkError: remarkError,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isSuccess,
    errorMessage,
    emailError,
    mobileError,
    remarkError,
  ];
}