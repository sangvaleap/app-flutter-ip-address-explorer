import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ip_checker/core/utils/app_asset.dart';
import 'package:ip_checker/core/utils/app_constant.dart';
import 'package:ip_checker/features/map/model/google_map.dart';
import 'package:ip_checker/features/map/model/map_model.dart';
import 'package:ip_checker/features/map/model/openstreet_map.dart';
import 'package:ip_checker/features/map/cubit/map_cubit.dart';
import 'package:ip_checker/features/map/cubit/map_state.dart';
import 'package:ip_checker/common/widgets/custom_card.dart';

class MapSettingPage extends StatelessWidget {
  const MapSettingPage({super.key});

  final _googleMap = const GoogleMapModel(
    name: "Google Map",
    imageUrl: AppAsset.googleMap,
  );
  final _openStreetMap = const OpenStreetMapModel(
    name: "Open Street Map",
    imageUrl: AppAsset.openStreetMap,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Map Setting",
        ),
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(context) {
    double width = MediaQuery.of(context).size.width;
    if (width >= AppConstant.minIpadScreenSizeWidth) {
      width = width * .5;
    }
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: width,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          shrinkWrap: true,
          children: [
            const SizedBox(height: 10),
            const Text("Please choose map"),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildOpenStreetMapBloc(context),
                _buildGoogleMapBloc(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoogleMapBloc(BuildContext context) {
    return _MapBox(
      mapStateMode: MapStateMode.google,
      mapModel: _googleMap,
      onTap: () {
        context
            .read<MapCubit>()
            .changeMap(const MapState(mode: MapStateMode.google));
      },
    );
  }

  Widget _buildOpenStreetMapBloc(BuildContext context) {
    return _MapBox(
      mapStateMode: MapStateMode.openstreet,
      mapModel: _openStreetMap,
      onTap: () {
        context
            .read<MapCubit>()
            .changeMap(const MapState(mode: MapStateMode.openstreet));
      },
    );
  }
}

class _MapBox extends StatelessWidget {
  const _MapBox(
      {required this.mapModel,
      required this.onTap,
      required this.mapStateMode});

  final MapModel mapModel;
  final MapStateMode mapStateMode;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: BlocBuilder<MapCubit, MapState>(
        builder: (context, state) {
          return Badge(
            isLabelVisible: state.mode == mapStateMode,
            offset: const Offset(10, -10),
            backgroundColor: Theme.of(context).primaryColor,
            largeSize: 30,
            label: const Icon(
              Icons.check,
              size: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CustomCard(
                  width: 130,
                  height: 200,
                  child: Image(
                    fit: BoxFit.cover,
                    image: AssetImage(mapModel.imageUrl),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(mapModel.name),
              ],
            ),
          );
        },
      ),
    );
  }
}
