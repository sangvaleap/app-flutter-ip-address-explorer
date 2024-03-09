import 'package:equatable/equatable.dart';

enum MapStateMode { openstreet, google }

class MapState extends Equatable {
  final MapStateMode mode;

  const MapState({this.mode = MapStateMode.openstreet});

  @override
  List<Object?> get props => [mode];
}
