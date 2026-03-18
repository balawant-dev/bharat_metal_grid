import 'package:bharat_metal_grid/screen/homeScreen/bloc/homeEvent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repo/eventRepo.dart';
import 'eventsEvent.dart';
import 'eventsState.dart';

class EventsBloc extends Bloc<EventsEvent,EventsState>{
  EventRepo api=EventRepo();
  EventsBloc() : super(EventsState()){
    on<ResetEventsEvent>((event, emit) {
      emit(EventsState());
    });


    on<FetchEventsEvent>(_onFetchDirectory);


  }

  Future<void> _onFetchDirectory(
      FetchEventsEvent event,
      Emitter<EventsState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final response = await api.getEventApi(context:event.context);
      if (response.success == true) {

        emit(
          state.copyWith(
            isLoading: false,
            getAllEventModel: response,
          ),
        );
      }
    } catch (e) {
      print(">>>>>>>>>>>>>>>>>>get getEventApi Exception Error>>>>$e");
    }
  }
}