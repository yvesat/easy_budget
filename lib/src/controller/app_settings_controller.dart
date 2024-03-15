import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/app_settings_model.dart';
import '../model/isar_service.dart';

class AppSettingsController extends StateNotifier<AsyncValue<void>> {
  AppSettingsController() : super(const AsyncValue.data(null));
  final IsarService _isarService = IsarService();

  Future<void> initAppSettings() async {
    final appSettings = await _isarService.getAppSettingsDB();

    if (appSettings == null) {
      final newAppSettings = AppSettingsModel();
      _isarService.saveAppSettingsDB(newAppSettings);
    }
  }

  Future<AppSettingsModel?> getAppSettings() async => await _isarService.getAppSettingsDB();

  Future<bool> changeRemeberCredentials() async {
    final appSettings = await _isarService.getAppSettingsDB();
    appSettings!.rememberCredentials = !appSettings.rememberCredentials;
    _saveAppSettings(appSettings);
    return appSettings.rememberCredentials;
  }

  void _saveAppSettings(AppSettingsModel modifiedAppSettings) {
    _isarService.saveAppSettingsDB(modifiedAppSettings);
  }
}

// final appSettingsControllerProvider = Provider((_) => AppSettingsController());
