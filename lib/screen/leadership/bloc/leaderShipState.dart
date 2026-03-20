import 'package:equatable/equatable.dart';

import '../model/leaderShipModel.dart';


class LeaderShipState extends Equatable {
  final bool isLoading;
  final bool isUpdateLoading;
  final String? errorMessage;
  final String? successMessage;
  final LeaderShipModel? leaderShipModel;

  // final UpdateProfileModel? updateProfileModel;





  const LeaderShipState({
    this.errorMessage,
    this.successMessage,
    this.leaderShipModel,

    this.isLoading = false,
    this.isUpdateLoading = false,



  });

  LeaderShipState copyWith({
    bool? isLoading,
    bool? isUpdateLoading,
    String? errorMessage,
    String? successMessage,
    LeaderShipModel? leaderShipModel,



  }) {
    return LeaderShipState(
      isLoading: isLoading ?? this.isLoading,
      isUpdateLoading: isUpdateLoading ?? this.isUpdateLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      leaderShipModel: leaderShipModel ?? this.leaderShipModel,




    );
  }

  @override
  List<Object?> get props => [isLoading, isUpdateLoading,errorMessage,successMessage];
}
