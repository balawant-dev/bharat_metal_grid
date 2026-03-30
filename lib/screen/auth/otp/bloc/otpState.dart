import 'dart:ui';

import 'package:equatable/equatable.dart';
class OTPState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool hasError;

  final String? displayMessage;
  final Color? messageColor;

  const OTPState({
    this.isLoading = false,
    this.isSuccess = false,
    this.hasError = false,
    this.displayMessage,
    this.messageColor,
  });

  OTPState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? hasError,
    String? displayMessage,
    Color? messageColor,
  }) {
    return OTPState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      hasError: hasError ?? this.hasError,
      displayMessage: displayMessage,
      messageColor: messageColor,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isSuccess,
    hasError,
    displayMessage,
    messageColor,
  ];
}