import 'package:bharat_metal_grid/screen/homeScreen/bloc/homeEvent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repo/cmsRepo.dart';
import 'cmsEvent.dart';
import 'cmsState.dart';

class CMSBloc extends Bloc<CMSEvent,CMSState>{
  CMSRepo api=CMSRepo();
  CMSBloc() : super(CMSState()){
    on<ResetCMSEvent>((event, emit) {
      emit(CMSState());
    });


    on<FetchCMSEvent>(_onFetchCMS);


  }

  Future<void> _onFetchCMS(
      FetchCMSEvent event,
      Emitter<CMSState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final response = await api.getCMSApi(context:event.context);
      if (response.success == true) {

        emit(
          state.copyWith(
            isLoading: false,
            cmsModel: response,
          ),
        );
      }
    } catch (e) {
      print(">>>>>>>>>>>>>>>>>>get getCMSApi Exception Error>>>>$e");
    }
  }
}