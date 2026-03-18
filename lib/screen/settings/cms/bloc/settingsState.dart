import 'package:equatable/equatable.dart';

import '../model/settingsModel.dart';

class SettingsState extends Equatable {
  final bool isLoading;
  final SettingResponseModel? settingResponseModel;
  final String? error;

  const SettingsState({
    this.isLoading = false,
    this.settingResponseModel,
    this.error,
  });

  SettingsState copyWith({
    bool? isLoading,
    SettingResponseModel? settingResponseModel,
    String? error,
  }) {
    return SettingsState(
      isLoading: isLoading ?? this.isLoading,
      settingResponseModel: settingResponseModel ?? this.settingResponseModel,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, settingResponseModel, error];
}
