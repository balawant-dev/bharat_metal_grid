import 'package:equatable/equatable.dart';

import '../model/getEventModel.dart';


class EventsState extends Equatable {
  final GetAllEventModel? getAllEventModel;

  
  final bool isLoading;
  final bool isUpdateLoading;
  final String? errorMessage;

  const EventsState({
    this.getAllEventModel,



    this.isLoading = false,
    this.isUpdateLoading = false,
    this.errorMessage,
  });

  EventsState copyWith({
    GetAllEventModel? getAllEventModel,

    bool? isLoading,
    bool? isUpdateLoading,
    String? errorMessage,
  }) {
    return EventsState(
      getAllEventModel: getAllEventModel ?? this.getAllEventModel,

      isLoading: isLoading ?? this.isLoading,
      isUpdateLoading: isUpdateLoading ?? this.isUpdateLoading,
      errorMessage: errorMessage ?? this.errorMessage,

    );
  }

  @override
  List<Object?> get props => [
    getAllEventModel,

    isLoading,
    isUpdateLoading,
    errorMessage,

  ];
}
