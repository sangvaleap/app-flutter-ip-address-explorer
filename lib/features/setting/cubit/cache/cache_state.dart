import 'package:equatable/equatable.dart';

enum CacheStateStatus { init, loading, success, error }

class CacheState extends Equatable {
  final CacheStateStatus status;
  final String message;
  const CacheState({this.status = CacheStateStatus.init, this.message = ''});

  @override
  List<Object?> get props => [status, message];
}
