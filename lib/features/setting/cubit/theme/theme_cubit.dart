import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ip_checker/core/services/storage_service.dart';
import 'package:ip_checker/core/utils/app_constant.dart';
import 'package:ip_checker/features/setting/cubit/theme/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({required ThemeState themeState}) : super(themeState) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    var mode = state.mode;
    var isDefault = await _loadThemeDefaultSystem();
    if (isDefault) {
      mode = _getSystemMode();
    } else {
      final stringMode =
          await StorageService.getString(AppConstant.themeModeKey);
      if (stringMode != null) {
        mode = (stringMode == ThemeMode.dark.name)
            ? ThemeMode.dark
            : ThemeMode.light;
      } else if (mode == ThemeMode.system) {
        mode = _getSystemMode();
      }
    }
    emit(ThemeState(mode: mode, isDefaultSystem: isDefault));
  }

  Future<bool> _loadThemeDefaultSystem() async {
    final isDefault =
        await StorageService.get(AppConstant.themeModeDefaultSystemKey);
    if (isDefault != null && isDefault as bool) {
      return true;
    }
    return false;
  }

  void setTheme(ThemeMode newMode) {
    if (newMode == state.mode) return;
    emit(ThemeState(mode: newMode));
    _saveThemeModeToStorage(newMode);
    _saveDefaultSystemThemeModeToStorage(false);
  }

  void setDefaultSystemTheme(bool isDefault) {
    var mode = state.mode;
    if (isDefault) {
      mode = _getSystemMode();
    }
    emit(ThemeState(mode: mode, isDefaultSystem: isDefault));
    _saveThemeModeToStorage(mode);
    _saveDefaultSystemThemeModeToStorage(isDefault);
  }

  ThemeMode _getSystemMode() {
    return SchedulerBinding.instance.platformDispatcher.platformBrightness ==
            Brightness.dark
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  _saveThemeModeToStorage(ThemeMode mode) {
    StorageService.saveString(AppConstant.themeModeKey, mode.name);
  }

  _saveDefaultSystemThemeModeToStorage(bool isDefault) {
    StorageService.save(AppConstant.themeModeDefaultSystemKey, isDefault);
  }
}
