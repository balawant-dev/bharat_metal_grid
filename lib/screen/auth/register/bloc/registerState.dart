import 'package:equatable/equatable.dart';

import '../model/getAllAssociationModel.dart';

class RegisterState extends Equatable {
  final bool isLoading;
  final bool isLoadingAssociation;
  final String?errorMessage;
 final GetAllAssociationModel? getAllAssociationModel;

  final bool isSuccess;

  final bool hasError;

  RegisterState({
    this.isLoading = false,
    this.isLoadingAssociation = false,
    this.hasError = false,
    this.isSuccess = false,
  this.getAllAssociationModel,


    this.errorMessage,
  });

  RegisterState copyWith({
     bool? isLoading,
     bool? isLoadingAssociation,
     String?errorMessage,
     bool? isSuccess,

     bool? hasError,
    GetAllAssociationModel? getAllAssociationModel,

}){
    return RegisterState(
      isLoading: isLoading?? this.isLoading,
        isLoadingAssociation: isLoadingAssociation?? this.isLoadingAssociation,
      errorMessage: errorMessage??this.errorMessage,
      hasError: hasError?? this.hasError,
      isSuccess: isSuccess ??this.isSuccess,
      getAllAssociationModel: getAllAssociationModel??this.getAllAssociationModel

    );

  }

@override
List<Object?>get props=>[isLoading,errorMessage,hasError,getAllAssociationModel];
}