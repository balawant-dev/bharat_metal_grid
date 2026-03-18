import 'package:equatable/equatable.dart';

import '../model/leaderShipModel.dart';


class LeaderShipState extends Equatable {
  final bool isLoading;
  final bool isUpdateLoading;
  final String? errorMessage;
  final LeaderShipModel? leaderShipModel;

  // final UpdateProfileModel? updateProfileModel;





  const LeaderShipState({
    this.errorMessage,
    this.leaderShipModel,

    this.isLoading = false,
    this.isUpdateLoading = false,



  });

  LeaderShipState copyWith({
    bool? isLoading,
    bool? isUpdateLoading,
    String? errorMessage,
    LeaderShipModel? leaderShipModel,



  }) {
    return LeaderShipState(
      isLoading: isLoading ?? this.isLoading,
      isUpdateLoading: isUpdateLoading ?? this.isUpdateLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      leaderShipModel: leaderShipModel ?? this.leaderShipModel,




    );
  }

  @override
  List<Object?> get props => [isLoading, isUpdateLoading,errorMessage,];
}
