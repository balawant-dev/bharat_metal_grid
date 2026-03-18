import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class MemberRegistrationSummitedEvent extends RegisterEvent {
  final BuildContext context;
  final String fullName;
  final String email;
  final String gender;
  final String state;
  final String language;
  final String organizationType;
  final String organizationName;
  final String parentOrganizationName;
  final String postalAddress;
  final String dateIncorporation;
  final String contactNumber;
  final String organizationEmailId;
  final String natureOrganization;
  final String panNumber;
  final String phoneNumber;
  final String designation;
  final String gstNumber;
  final List selectAssociation;
  final File? profileImage;

  const MemberRegistrationSummitedEvent({
    required this.fullName,
    required this.email,
    required this.gender,
    required this.phoneNumber,
    required this.designation,
    required this.state,
    required this.language,
    required this.organizationType,
    required this.selectAssociation,
    required this.organizationName,
    required this.parentOrganizationName,
    required this.postalAddress,
    required this.dateIncorporation,
    required this.contactNumber,
    required this.organizationEmailId,
    required this.natureOrganization,
    required this.panNumber,
    required this.gstNumber,
    required this.profileImage,
    required this.context,
  });

  @override
  List<Object?> get props => [
    organizationName,
    context,
    email,
    phoneNumber,
    designation,
    gender,
    language,
    state,
    organizationType,
    selectAssociation,
    fullName,
    parentOrganizationName,
    postalAddress,
    dateIncorporation,
    contactNumber,
    organizationEmailId,
    natureOrganization,
    panNumber,
    gstNumber,
    profileImage,



  ];
}

class AssociationRegistrationSummitedEvent extends RegisterEvent {
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
  final String mobile;
  final String registrationCertificateType;
  final String verifiedBy;
  final String verifiedAt;

  final File? profileImage ;
  final File? registrationCertificateImage ;

  const AssociationRegistrationSummitedEvent({
    required this.associationName,
    required this.email,
    required this.registrationCertificateImage,
    required this.city,
    required this.fullAddress,
    required this.govtLegalRegistrationNumber,
    required this.mobile,
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
    mobile,
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
class AllAssociationEvent extends RegisterEvent{
  BuildContext context;

  AllAssociationEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class ResetRegisterEvent extends RegisterEvent {
  const ResetRegisterEvent();
}
