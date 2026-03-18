import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class FetchProfileAssociationEvent extends ProfileEvent {
  final BuildContext context;

  const FetchProfileAssociationEvent({required this.context});

  @override
  List<Object?> get props => [context];
}class FetchProfileMemberEvent extends ProfileEvent {
  final BuildContext context;

  const FetchProfileMemberEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class ResetProfileEvent extends ProfileEvent {
  const ResetProfileEvent();
}

class AssociationUpdateSummitedEvent extends ProfileEvent {
  final BuildContext context;
  final String associationName;
  final String govtLegalRegistrationNumber;
  final String yearFormation;
  final String fullAddress;
  final String selectState;
  final String pin;
  final String city;
  final String presidentSecretary;
  final String email;
  // final String mobile;
  final String registrationCertificateType;
  final String verifiedBy;
  final String verifiedAt;

  final File? profileImage ;
  final File? registrationCertificateImage ;

  const AssociationUpdateSummitedEvent({
    required this.associationName,
    required this.email,
    required this.registrationCertificateImage,
    required this.city,
    required this.fullAddress,
    required this.govtLegalRegistrationNumber,
    // required this.mobile,
    required this.presidentSecretary,
    required this.registrationCertificateType,
    required this.selectState,
    required this.verifiedAt,
    required this.verifiedBy,
    required this.pin,
    required this.yearFormation,

    required this.profileImage,
    required this.context,
  });

  @override
  List<Object?> get props => [

    context,
    email,
    profileImage,
    registrationCertificateImage,
    city,
    fullAddress,
    govtLegalRegistrationNumber,
    // mobile,
    presidentSecretary,
    registrationCertificateType,
    selectState,
    verifiedAt,
    verifiedBy,
    pin,
    yearFormation,
    associationName,







  ];
}

// class UpdateProfileEvent extends ProfileEvent {
//   final String name;
//   final String email;
//   final File? image;
//   final BuildContext context;
//
//   const UpdateProfileEvent({
//     required this.name,
//     required this.context,
//     required this.image,
//     required this.email,
//   });
//
//   @override
//   List<Object?> get props => [name, context, email, image];
// }




