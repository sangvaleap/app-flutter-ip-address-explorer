import 'package:equatable/equatable.dart';

abstract class MapModel extends Equatable {
  final String name;
  final String imageUrl;
  final String? providerUrl;
  const MapModel({
    required this.name,
    required this.imageUrl,
    this.providerUrl,
  });

  @override
  List<Object?> get props => [name, imageUrl, providerUrl];
}
