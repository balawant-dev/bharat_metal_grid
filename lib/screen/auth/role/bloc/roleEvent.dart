import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SelectRoleEvent extends Equatable {
  const SelectRoleEvent();

  @override
  List<Object?> get props => [];
}

class VerifyRoleEvent extends SelectRoleEvent {
  final String mobileNumber;

  final String userType;
  final BuildContext context;

  const VerifyRoleEvent({required this.mobileNumber,required this.context,required this.userType,});

  @override
  List<Object?> get props => [mobileNumber,context,userType];
}

class ResetVerifyRoleEvent extends SelectRoleEvent {
  const ResetVerifyRoleEvent();
}
