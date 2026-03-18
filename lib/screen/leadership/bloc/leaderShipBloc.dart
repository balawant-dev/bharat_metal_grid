
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





        emit(
          state.copyWith(
            isLoading: false,
            leaderShipModel: response,
          ),
        );
      }
    } catch (e) {
      print(">>>>>>>>>>>>>>>>>>get Profile Exception Error>>>>$e");
    }
  }


}
