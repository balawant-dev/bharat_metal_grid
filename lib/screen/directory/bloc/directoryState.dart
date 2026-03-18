import 'package:equatable/equatable.dart';

import '../model/getDirectoryModel.dart';


class DirectoryState extends Equatable {
  final GetDirectoryModel? getDirectoryModel;

  
  final bool isLoading;
  final bool isUpdateLoading;
  final String? errorMessage;

  const DirectoryState({
    this.getDirectoryModel,



    this.isLoading = false,
    this.isUpdateLoading = false,
    this.errorMessage,
  });

  DirectoryState copyWith({
    GetDirectoryModel? getDirectoryModel,

    bool? isLoading,
    bool? isUpdateLoading,
    String? errorMessage,
  }) {
    return DirectoryState(
      getDirectoryModel: getDirectoryModel ?? this.getDirectoryModel,

      isLoading: isLoading ?? this.isLoading,
      isUpdateLoading: isUpdateLoading ?? this.isUpdateLoading,
      errorMessage: errorMessage ?? this.errorMessage,

    );
  }

  @override
  List<Object?> get props => [
    getDirectoryModel,

    isLoading,
    isUpdateLoading,
    errorMessage,

  ];
}
