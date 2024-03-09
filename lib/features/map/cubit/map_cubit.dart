import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ip_checker/core/services/storage_service.dart';
import 'package:ip_checker/core/utils/app_constant.dart';
import 'package:ip_checker/features/map/cubit/map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit({required MapState initState}) : super(initState) {
    _initMap();
  }

  void _initMap() async {
    var mapMode = state.mode;
    final stringMapMode =
        await StorageService.getString(AppConstant.mapModeKey);
    if (stringMapMode != null) {
      mapMode = (stringMapMode == MapStateMode.google.name)
          ? MapStateMode.google
          : MapStateMode.openstreet;
    }
    emit(MapState(mode: mapMode));
  }

  void changeMap(MapState mapState) {
    if (mapState.mode == state.mode) return;
    emit(mapState);
    StorageService.saveString(AppConstant.mapModeKey, mapState.mode.name);
  }
}
