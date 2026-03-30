import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ComplaintEvent extends Equatable {
  const ComplaintEvent();

  @override
  List<Object?> get props => [];
}

class SubmitComplaintEvent extends ComplaintEvent {
  final BuildContext context;
  final String email;
  final String mobile;
  final String remark;

  const SubmitComplaintEvent({
    required this.context,
    required this.email,
    required this.mobile,
    required this.remark,
  });

  @override
  List<Object?> get props => [email, mobile, remark];
}