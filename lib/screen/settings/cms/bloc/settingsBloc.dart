import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../auth/repo/authRepo.dart';
import '../../appSettings/appSettings.dart';
import 'settingsEvent.dart';
import 'settingsState.dart';


class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
   AuthRepo repo=AuthRepo();

   SettingsBloc() : super(const SettingsState()) {
    on<FetchSettingsEvent>(_onFetchSettings);
  }

   Future<void> _onFetchSettings(
       FetchSettingsEvent event,
       Emitter<SettingsState> emit,
       ) async {
     emit(state.copyWith(isLoading: true, error: null));

     try {
       final response = await repo.getSettingsApi(context: event.context);

       if (response != null) {
         // ✅ SAVE EVERYTHING GLOBALLY
         AppSettings.setSettings(response);

         emit(state.copyWith(
           isLoading: false,
           settingResponseModel: response,
         ));
       } else {
         emit(state.copyWith(
             isLoading: false, error: "No data found"));
       }
     } catch (e) {
       emit(state.copyWith(isLoading: false, error: e.toString()));
     }
}}
