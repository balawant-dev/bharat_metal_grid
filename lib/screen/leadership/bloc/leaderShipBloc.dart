import 'package:flutter_bloc/flutter_bloc.dart';

import '../repo/leaderShipRepo.dart';

import 'leaderShipEvent.dart';
import 'leaderShipState.dart';

class LeaderShipBloc extends Bloc<LeaderShipEvent, LeaderShipState> {
  LeaderShipRepo api = LeaderShipRepo();

  LeaderShipBloc() : super(LeaderShipState()) {
    on<ResetLeaderShipEvent>((event, emit) {
      emit(LeaderShipState());
    });
    on<FetchLeaderShipEvent>(_onFetchLeaderShip);
    on<PostLeaderShipSummitedEvent>(_onPostLeaderShip);
  }

  Future<void> _onFetchLeaderShip(
    FetchLeaderShipEvent event,
    Emitter<LeaderShipState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final response = await api.getLeaderShip(event.context);
      if (response.success == true) {
        print("Leader Board 😂😂😂😂");

        emit(state.copyWith(isLoading: false, leaderShipModel: response));
      }
    } catch (e) {
      print(">>>>>>>>>>>>>>>>>>get Profile Exception Error>>>>$e");
    }
  }

  Future<void> _onPostLeaderShip(
    PostLeaderShipSummitedEvent event,
    Emitter<LeaderShipState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final response = await api.postLeaderShipApi(
        context: event.context,

        designation: event.designation,//  enum: ["President", "Vice-President", "Secretary", "Treasurer"],
        name: event.name,
        profileImg: event.profileImg,
      );
      if (response != null && response.success == true) {
        emit(
          state.copyWith(
            isLoading: false,
            successMessage: response.message ?? "Added Successfully",
            errorMessage: null,
          ),
        );
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: "Something went wrong",
            successMessage: null,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
