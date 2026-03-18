import 'package:bharat_metal_grid/screen/homeScreen/bloc/homeEvent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repo/directoryRepo.dart';
import 'directoryEvent.dart';
import 'directoryState.dart';

class DirectoryBloc extends Bloc<DirectoryEvent,DirectoryState>{
  DirectoryRepo api=DirectoryRepo();
  DirectoryBloc() : super(DirectoryState()){
    on<ResetDirectoryEvent>((event, emit) {
      emit(DirectoryState());
    });


    on<FetchDirectoryEvent>(_onFetchDirectory);


  }

  Future<void> _onFetchDirectory(
      FetchDirectoryEvent event,
      Emitter<DirectoryState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final response = await api.getDirectoryApi(context:event.context);
      if (response.status == true) {

        emit(
          state.copyWith(
            isLoading: false,
            getDirectoryModel: response,
          ),
        );
      }
    } catch (e) {
      print(">>>>>>>>>>>>>>>>>>get getDirectoryApi Exception Error>>>>$e");
    }
  }
}