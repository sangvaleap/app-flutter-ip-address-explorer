import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ip_checker/core/services/geolocation_service.dart';
import 'package:ip_checker/core/utils/app_asset.dart';
import 'package:ip_checker/core/utils/app_constant.dart';
import 'package:ip_checker/features/ip_checker/cubit/ip_checker_cubit.dart';
import 'package:ip_checker/features/ip_checker/cubit/ip_checker_state.dart';
import 'package:ip_checker/features/ip_checker/model/ip_location.dart';
import 'package:ip_checker/features/map/cubit/map_cubit.dart';
import 'package:ip_checker/features/map/cubit/map_state.dart';
import 'package:ip_checker/features/setting/cubit/theme/theme_cubit.dart';
import 'package:ip_checker/features/setting/cubit/theme/theme_state.dart';
import 'package:latlong2/latlong.dart';

/// The `FlutterMapWidget` class is a `StatefulWidget` that displays a map using the FlutterMap package.
class OpenStreetMapWidget extends StatefulWidget {
  const OpenStreetMapWidget({super.key});

  @override
  State<OpenStreetMapWidget> createState() => _OpenStreetMapWidgetState();
}

class _OpenStreetMapWidgetState extends State<OpenStreetMapWidget> {
  // The initial position on the map.
  LatLng _initLocation = const LatLng(41.00753218708659, -91.96316909993935);
  // The initial zoom level of the map.
  final double _zoom = 17;
  // The controller for interacting with the FlutterMap.
  late MapController _mapController;
  // The marker object representing a location on the map.
  Marker? _marker;
  // The marker icon.
  Widget? _markerIcon;
  // The size of the marker icon.
  final _markerIconSize = const Size(50, 50);

  @override
  void initState() {
    super.initState();
    _initData();
  }

  _initData() async {
    _mapController = MapController();
    _setInitLocation();
  }

  _setInitLocation() {
    IPLocation? ipLocation =
        context.read<IPCheckerCubit>().state.ipInfo?.ipLocation;

    var currentPosition = GeolocatorService.currentPosition;
    if (ipLocation != null) {
      _initLocation = LatLng(ipLocation.lat, ipLocation.lng);
    } else if (currentPosition != null) {
      _initLocation =
          LatLng(currentPosition.latitude, currentPosition.longitude);
    }
  }

  // dispose resources to prevent memory leak
  @override
  void dispose() {
    super.dispose();
    _mapController.dispose();
  }

  // Build map with styles and theme based on state changes in MapCubit and ThemeCubit respectively
  // Build map based on state changes in the IPCheckerCubit
  // and executes the specified callback when the state changes.
  // On success, _updateMap(position) will be triggered to update map based on IP Address information.
  // On error or failure, re_removeMarker() will be triggered to remove marker from map.
  // Else, map remains the same state
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeCubit, ThemeState>(
      listener: (context, themeState) {
        _setMarkerIcon(themeState.mode);
      },
      builder: (_, themeState) {
        return BlocBuilder<MapCubit, MapState>(
          builder: (_, mapState) {
            return BlocBuilder<IPCheckerCubit, IPCheckerState>(
              builder: (context, ipCheckerState) {
                if (ipCheckerState.status == IPCheckerStatus.success) {
                  var location = ipCheckerState.ipInfo!.ipLocation;
                  _updateMap(LatLng(location.lat, location.lng));
                } else if (ipCheckerState.status == IPCheckerStatus.error) {
                  _removeMarker();
                }
                return _getMap(mapState.mode, themeState.mode);
              },
            );
          },
        );
      },
    );
  }

  // Builds the FlutterMap widget with initial options and layers.
  Widget _getMap(MapStateMode mapMode, ThemeMode themeMode) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: _initLocation,
        initialZoom: _zoom,
      ),
      children: [
        TileLayer(
          urlTemplate: mapMode == MapStateMode.google
              ? AppConstant.googleMapProvider
              : AppConstant.openStreetMapProvider,
          tileBuilder: themeMode == ThemeMode.dark ? darkModeTileBuilder : null,
        ),
        _getdMarkers(),
      ],
    );
  }

  // Updates the map to a new center position.
  Future<void> _updateMap(LatLng position) async {
    _mapController.move(position, _zoom);
    _setMarker(position);
  }

  // Removes the marker from the map.
  void _removeMarker() {
    _marker = null;
  }

  // Sets a marker with custom icon at the specified position on the map.
  void _setMarker(LatLng position) {
    _marker = Marker(
      point: position,
      width: _markerIconSize.width,
      height: _markerIconSize.height,
      child: _markerIcon ?? const SizedBox(),
    );
  }

  void _setMarkerIcon(ThemeMode mode) {
    _markerIcon = SvgPicture.asset(
      AppAsset.locationIcon,
      colorFilter: ColorFilter.mode(
          mode == ThemeMode.dark ? Colors.white : Colors.black,
          BlendMode.srcIn),
    );
  }

  // Builds the MarkerLayer with markers on the map.
  Widget _getdMarkers() {
    return _marker != null
        ? MarkerLayer(
            markers: [_marker!],
          )
        : const SizedBox();
  }
}
